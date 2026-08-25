-- =======================================================
-- SQL 1: สร้างตาราง profiles
-- =======================================================
CREATE TABLE IF NOT EXISTS public.profiles (
  id UUID REFERENCES auth.users(id) ON DELETE CASCADE PRIMARY KEY,
  username TEXT,
  avatar_color TEXT,
  avatar_url TEXT,
  dietary_restrictions JSONB DEFAULT '[]'::jsonb,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT timezone('utc'::text, now()) NOT NULL
);

-- =======================================================
-- SQL 2: อนุญาตให้ผู้ใช้เข้าถึงและแก้ไขข้อมูล Profile ของตัวเอง (RLS Policies)
-- =======================================================
ALTER TABLE public.profiles ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Public profiles are viewable by everyone."
  ON public.profiles FOR SELECT
  USING ( true );

CREATE POLICY "Users can insert their own profile."
  ON public.profiles FOR INSERT
  WITH CHECK ( auth.uid() = id );

CREATE POLICY "Users can update own profile."
  ON public.profiles FOR UPDATE
  USING ( auth.uid() = id );

-- =======================================================
-- SQL 3: สร้างฟังก์ชัน (Trigger) เพื่อสร้าง Profile อัตโนมัติเวลาสมัคร
-- =======================================================
CREATE OR REPLACE FUNCTION public.handle_new_user()
RETURNS trigger AS $$
BEGIN
  INSERT INTO public.profiles (id, username, avatar_color)
  VALUES (
    new.id, 
    -- ใช้ชื่อ-สกุลจาก metadata ถ้ามี (ถ้าไม่มีใช้อีเมลส่วนหน้าแทน)
    COALESCE(new.raw_user_meta_data->>'display_name', split_part(new.email, '@', 1)),
    -- สุ่มสีพื้นหลัง
    (ARRAY['#F97316', '#3B82F6', '#10B981', '#8B5CF6', '#EC4899'])[floor(random() * 5 + 1)]
  );
  RETURN new;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- นำ Trigger ไปผูกกับ auth.users
DROP TRIGGER IF EXISTS on_auth_user_created ON auth.users;
CREATE TRIGGER on_auth_user_created
  AFTER INSERT ON auth.users
  FOR EACH ROW EXECUTE PROCEDURE public.handle_new_user();

-- =======================================================
-- SQL 4: สคริปต์แก้ไขสำหรับคนที่มี User อยู่แล้วแต่ยังไม่มี Profile
-- =======================================================
INSERT INTO public.profiles (id, username, avatar_color)
SELECT 
  id, 
  COALESCE(raw_user_meta_data->>'display_name', split_part(email, '@', 1)) AS username, 
  (ARRAY['#F97316', '#3B82F6', '#10B981', '#8B5CF6', '#EC4899'])[floor(random() * 5 + 1)] AS avatar_color
FROM auth.users
WHERE NOT EXISTS (
  SELECT 1 FROM public.profiles WHERE profiles.id = auth.users.id
);

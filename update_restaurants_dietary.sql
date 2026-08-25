-- =======================================================
-- SQL: เพิ่มฟิลด์ dietary_tags ให้กับตาราง restaurants
-- =======================================================

-- 1. เพิ่มคอลัมน์ dietary_tags (เก็บเป็นอาร์เรย์ JSON)
ALTER TABLE public.restaurants 
ADD COLUMN IF NOT EXISTS dietary_tags JSONB DEFAULT '[]'::jsonb;

-- 2. จำลองข้อมูล (Mock Data) สำหรับร้านอาหารในระบบให้มีแท็กพื้นฐาน
-- หมายเหตุ: ข้อมูลนี้เป็นเพียงการจำลองเพื่อให้ระบบคัดกรองทำงานได้

-- ให้ทุกร้านมีแท็กพื้นฐานเหล่านี้ (ส่วนใหญ่จะทำได้)
UPDATE public.restaurants 
SET dietary_tags = '["seafood_allergy", "peanut_allergy", "lactose_intolerant", "no_beef"]'::jsonb;

-- ร้านคาเฟ่ / อาหารนานาชาติ มักจะมีเมนูมังสวิรัติและวีแกน
UPDATE public.restaurants 
SET dietary_tags = dietary_tags || '["vegetarian", "vegan", "gluten_free"]'::jsonb
WHERE category IN ('คาเฟ่/อาหารเช้า', 'อาหารนานาชาติ');

-- ร้านอาหารจานเดียว / อาหารญี่ปุ่น จำลองให้เป็นฮาลาลและไม่มีหมู เพื่อให้ทดสอบได้
UPDATE public.restaurants 
SET dietary_tags = dietary_tags || '["halal", "no_pork"]'::jsonb
WHERE category IN ('อาหารจานเดียว', 'อาหารญี่ปุ่น');

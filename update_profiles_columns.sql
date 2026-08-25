-- =======================================================
-- SQL: เพิ่มคอลัมน์ใหม่ในตาราง profiles สำหรับเก็บการตั้งค่าการจับคู่
-- =======================================================

ALTER TABLE public.profiles 
ADD COLUMN IF NOT EXISTS lat DOUBLE PRECISION,
ADD COLUMN IF NOT EXISTS lng DOUBLE PRECISION,
ADD COLUMN IF NOT EXISTS location_name TEXT,
ADD COLUMN IF NOT EXISTS max_distance INTEGER DEFAULT 5,
ADD COLUMN IF NOT EXISTS price_levels TEXT[] DEFAULT '{}';

-- Add settings columns to profiles table
ALTER TABLE public.profiles
ADD COLUMN IF NOT EXISTS lat NUMERIC,
ADD COLUMN IF NOT EXISTS lng NUMERIC,
ADD COLUMN IF NOT EXISTS location_name TEXT,
ADD COLUMN IF NOT EXISTS max_distance INT DEFAULT 5,
ADD COLUMN IF NOT EXISTS price_levels JSONB DEFAULT '[]'::jsonb;

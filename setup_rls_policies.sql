-- Enable RLS on all necessary tables
ALTER TABLE public.rooms ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.room_members ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.swipes ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.matches ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.profiles ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.restaurants ENABLE ROW LEVEL SECURITY;

-- Drop existing policies to avoid conflicts if you run this multiple times
DROP POLICY IF EXISTS "Allow authenticated full access to rooms" ON public.rooms;
DROP POLICY IF EXISTS "Allow authenticated full access to room_members" ON public.room_members;
DROP POLICY IF EXISTS "Allow authenticated full access to swipes" ON public.swipes;
DROP POLICY IF EXISTS "Allow authenticated full access to matches" ON public.matches;
DROP POLICY IF EXISTS "Allow authenticated full access to profiles" ON public.profiles;
DROP POLICY IF EXISTS "Allow authenticated read to restaurants" ON public.restaurants;

-- Create ALL access policies for authenticated users
-- (For a real production app, you might want to restrict this further, 
-- e.g., only letting users update their OWN rooms, but for this prototype, allowing all authenticated users prevents blocking issues)

CREATE POLICY "Allow authenticated full access to rooms"
ON public.rooms
FOR ALL
TO authenticated
USING (true)
WITH CHECK (true);

CREATE POLICY "Allow authenticated full access to room_members"
ON public.room_members
FOR ALL
TO authenticated
USING (true)
WITH CHECK (true);

CREATE POLICY "Allow authenticated full access to swipes"
ON public.swipes
FOR ALL
TO authenticated
USING (true)
WITH CHECK (true);

CREATE POLICY "Allow authenticated full access to matches"
ON public.matches
FOR ALL
TO authenticated
USING (true)
WITH CHECK (true);

CREATE POLICY "Allow authenticated full access to profiles"
ON public.profiles
FOR ALL
TO authenticated
USING (true)
WITH CHECK (true);

CREATE POLICY "Allow authenticated read to restaurants"
ON public.restaurants
FOR SELECT
TO authenticated
USING (true);

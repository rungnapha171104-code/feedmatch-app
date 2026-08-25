// Supabase Project Reference: bawnspivtjggvwdfweyc
const SUPABASE_URL = 'https://bawnspivtjggvwdfweyc.supabase.co';
const SUPABASE_ANON_KEY = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImJhd25zcGl2dGpnZ3Z3ZGZ3ZXljIiwicm9sZSI6ImFub24iLCJpYXQiOjE3ODcwNDQ5ODYsImV4cCI6MjEwMjYyMDk4Nn0.NlLA5c1cq_Tcln45MCNRg3l0U89viDhzBDpP4QAde0U';

// Create a single supabase client for interacting with your database
const supabaseClient = supabase.createClient(SUPABASE_URL, SUPABASE_ANON_KEY);

console.log("🚀 Supabase Initialized and Connected!");

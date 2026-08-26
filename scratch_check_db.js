const { createClient } = require('@supabase/supabase-js');
const fs = require('fs');

// Read supabase config from js/supabase-config.js
const configContent = fs.readFileSync('js/supabase-config.js', 'utf-8');
const urlMatch = configContent.match(/const\s+supabaseUrl\s*=\s*['"]([^'"]+)['"]/);
const keyMatch = configContent.match(/const\s+supabaseAnonKey\s*=\s*['"]([^'"]+)['"]/);

if (urlMatch && keyMatch) {
    const supabase = createClient(urlMatch[1], keyMatch[1]);
    
    async function checkRestaurants() {
        const { data, error } = await supabase.from('restaurants').select('id, name, lat, lng').limit(5);
        if (error) {
            console.error(error);
        } else {
            console.log(data);
        }
    }
    checkRestaurants();
} else {
    console.log("Could not parse supabase config");
}

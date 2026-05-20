const fs = require('fs');
const path = require('path');

const htmlPath = path.join(__dirname, 'fnf-collection', 'index.html');
const html = fs.readFileSync(htmlPath, 'utf-8');

// Extract the modData array using regex
const match = html.match(/const modData = (\[[\s\S]*?\]);/);
if (!match) {
  console.error("Could not find modData in index.html");
  process.exit(1);
}

const modData = JSON.parse(match[1]);
const imagesDir = path.join(__dirname, 'assets', 'images');

console.log(`Checking ${modData.length} mods...`);
let brokenCount = 0;

modData.forEach(mod => {
  // Extract the filename from path like "../assets/images/filename.webp"
  const imgUrl = mod.img;
  const fileName = path.basename(imgUrl);
  const fullPath = path.join(imagesDir, fileName);

  if (!fs.existsSync(fullPath)) {
    console.log(`❌ Broken: Mod #${mod.id} "${mod.title}" uses image "${fileName}" which DOES NOT exist.`);
    brokenCount++;
  }
});

console.log(`Done. Found ${brokenCount} broken images.`);

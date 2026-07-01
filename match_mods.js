const fs = require('fs');
const path = require('path');

const names = fs.readFileSync('names.txt', 'utf-8').split('\n').map(l => l.trim()).filter(Boolean);
const urls = fs.readFileSync('urls.txt', 'utf-8').split('\n').map(l => l.trim()).filter(Boolean);
const imageDir = path.join(__dirname, 'assets', 'images');
const images = fs.readdirSync(imageDir).filter(f => f.endsWith('.webp') || f.endsWith('.png'));

function getWords(text) {
  return text.toLowerCase()
    .replace(/[’']/g, ' s ') // Map curly/straight quote to ' s ' to match "-s-" in filenames
    .replace(/[^\w\s]/g, ' ') // Replace other punctuation with spaces
    .split(/\s+/)
    .filter(w => w.length > 0);
}

function getBestMatch(name, images) {
  const nameWords = getWords(name);
  const nameWordsWithFnf = nameWords.includes('fnf') ? nameWords : ['fnf', ...nameWords];
  
  let bestImg = null;
  let maxScore = 0;
  
  for (let img of images) {
    const imgBase = img.replace(/\.(webp|png|jpe?g)$/i, '');
    const imgWords = getWords(imgBase);
    
    // Count how many words overlap
    let matchCount = 0;
    for (let w of nameWordsWithFnf) {
      if (imgWords.includes(w)) {
        matchCount++;
      }
    }
    
    // Simple overlap score normalized by the larger word count
    const score = matchCount / Math.max(nameWordsWithFnf.length, imgWords.length);
    
    if (score > maxScore) {
      maxScore = score;
      bestImg = img;
    }
  }
  
  // Reasonably strict threshold to avoid false positives
  if (maxScore > 0.4) {
    return bestImg;
  }
  
  return 'play-fnf.webp'; // Use play-fnf.webp as default fallback since it actually exists
}

let modData = [];
for (let i = 0; i < names.length; i++) {
  const name = names[i];
  const url = urls[i] || "https://fnfgame24.com";
  const imgName = getBestMatch(name, images);
  const imgUrl = `../assets/images/${imgName}`; // Keep it relative as we modified it earlier
  modData.push({
    id: i + 1,
    title: name,
    img: imgUrl,
    iframe: url
  });
}

const output = `const modData = ${JSON.stringify(modData, null, 2)};`;
fs.writeFileSync('modData.js', output);
console.log('Names:', names.length, 'URLs:', urls.length);
console.log('Generated modData.js with ' + modData.length + ' items.');

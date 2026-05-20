const fs = require('fs');
let html = fs.readFileSync('fnf-collection/index.html', 'utf-8');
const modData = fs.readFileSync('modData.js', 'utf-8');

// Replace modData
html = html.replace(/const modData = \[\s*\{[\s\S]*?\s*\];/s, modData);

// Replace mod-count
const matchCount = modData.match(/"id":/g).length;
html = html.replace(/<div class="mod-count">\d+<\/div>/g, `<div class="mod-count">${matchCount}</div>`);

fs.writeFileSync('fnf-collection/index.html', html);
console.log('Successfully updated index.html with ' + matchCount + ' mods.');

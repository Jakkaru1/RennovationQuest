// Builds index.html (a complete web page for GitHub Pages) from renovation-quest.html (the Claude artifact source).
// Run: node build-pages.js
const fs = require('fs');
const src = fs.readFileSync(__dirname + '/renovation-quest.html', 'utf8');
const reset = ':root{color-scheme:light;box-sizing:border-box;padding-top:env(safe-area-inset-top,0px);padding-bottom:env(safe-area-inset-bottom,0px)}html{scroll-padding-top:env(safe-area-inset-top,0px)}body{margin:0;padding:0;font:14px -apple-system,BlinkMacSystemFont,sans-serif;background:#fff;color:#000}img{max-width:100%}[hidden]{display:none!important}';
const html = '<!doctype html>\n<html lang="en">\n<head>\n<meta charset="utf-8">\n<meta name="viewport" content="width=device-width,initial-scale=1,viewport-fit=cover">\n<style>' + reset + '</style>\n</head>\n<body>\n' + src.trim() + '\n</body>\n</html>\n';
fs.writeFileSync(__dirname + '/index.html', html);
console.log('index.html written,', html.length, 'bytes');

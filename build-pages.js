// Builds index.html (a complete web page for GitHub Pages) from renovation-quest.html (the Claude artifact source).
// Run: node build-pages.js
const fs = require('fs');
const src = fs.readFileSync(__dirname + '/renovation-quest.html', 'utf8');
const reset = ':root{color-scheme:light;box-sizing:border-box;padding-top:env(safe-area-inset-top,0px);padding-bottom:env(safe-area-inset-bottom,0px)}html{scroll-padding-top:env(safe-area-inset-top,0px)}body{margin:0;padding:0;font:14px -apple-system,BlinkMacSystemFont,sans-serif;background:#fff;color:#000}img{max-width:100%}[hidden]{display:none!important}';
const SITE = 'https://jakkaru1.github.io/RennovationQuest/';
const DESC = 'Our flat renovation, 8-bit style: progress, jobs done, jobs next, the crew and the floor plan.';
// Link-preview tags (WhatsApp, Messenger, iMessage, Facebook, X...). The image URL must be absolute.
// og-image.png is drawn by make-preview.ps1.
const meta = [
  '<title>Renovation Quest</title>',
  '<meta name="description" content="' + DESC + '">',
  '<meta property="og:type" content="website">',
  '<meta property="og:site_name" content="Renovation Quest">',
  '<meta property="og:title" content="Renovation Quest">',
  '<meta property="og:description" content="' + DESC + '">',
  '<meta property="og:url" content="' + SITE + '">',
  '<meta property="og:image" content="' + SITE + 'og-image.png">',
  '<meta property="og:image:type" content="image/png">',
  '<meta property="og:image:width" content="1200">',
  '<meta property="og:image:height" content="630">',
  '<meta property="og:image:alt" content="Renovation Quest: a pixel-art construction worker next to a progress bar">',
  '<meta name="twitter:card" content="summary_large_image">',
  '<meta name="theme-color" content="#1f1c19">'
].join('\n');
// The artifact source carries its own <title> in the body; the head has it now.
const body = src.trim().replace(/<title>[^<]*<\/title>\s*/, '');
const html = '<!doctype html>\n<html lang="en">\n<head>\n<meta charset="utf-8">\n<meta name="viewport" content="width=device-width,initial-scale=1,viewport-fit=cover">\n' + meta + '\n<style>' + reset + '</style>\n</head>\n<body>\n' + body + '\n</body>\n</html>\n';
fs.writeFileSync(__dirname + '/index.html', html);
console.log('index.html written,', html.length, 'bytes');

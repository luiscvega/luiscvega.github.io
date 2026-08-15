const http = require('http');
const fs = require('fs');
const path = require('path');

const types = {
  '.html': 'text/html',
  '.css': 'text/css',
  '.js': 'application/javascript',
  '.json': 'application/json',
  '.svg': 'image/svg+xml',
  '.png': 'image/png',
  '.csv': 'text/csv',
};
const root = __dirname;

http.createServer((req, res) => {
  // Strip the query before resolving, so "/?debug=1" still maps to index.html
  // rather than trying to read the directory itself.
  const pathname = decodeURIComponent(req.url.split('?')[0]);
  const filePath = path.join(root, pathname === '/' ? '/index.html' : pathname);
  fs.readFile(filePath, (err, data) => {
    if (err) { res.writeHead(404); res.end('Not found'); return; }
    const ext = path.extname(filePath);
    res.writeHead(200, { 'Content-Type': types[ext] || 'application/octet-stream' });
    res.end(data);
  });
}).listen(8081, () => console.log('listening on 8081'));

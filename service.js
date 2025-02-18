
const { createServer } = require('http');
const { parse } = require('url');
const next = require('next');
const fs = require('fs');

const dev = process.env.NODE_ENV !== 'production';
const port = process.env.PORT || 3005;
const app = next({ dev });
const handle = app.getRequestHandler();


app.prepare().then(() => {
  createServer((req, res) => {
    const parsedUrl = parse(req.url, true);
    handle(req, res, parsedUrl);

  }).listen(port, err => {
    if (err) throw err;
    console.log(port);
  });
});
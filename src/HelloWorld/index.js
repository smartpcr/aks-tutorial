const http = require("http");
const os = require("os");

console.log(`Kubia server starting...`);

const server = http.createServer((req, resp) => {
    console.log(`Received request for ${req.url}`);
    resp.writeHead(200);
    resp.end(`You hit ${os.hostname()}\n`);
});

server.listen(8001);
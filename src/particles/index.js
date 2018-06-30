const http = require("http");
const os = require("os");

const server = http.createServer((req, resp) => {
    resp.writeHead(200, { "Content-Type": "text/html" });
    resp.end("<body>" +
        "Hello World this is a really cool test for kube" +
        "<br>Served by: \n" + os.hostname() +
        "</body>");
    console.log(`Request handled ${req.url} at ${Date.now()}`);
});

server.listen(8000);
console.log("Server running at http://" + os.hostname() + ":8000");
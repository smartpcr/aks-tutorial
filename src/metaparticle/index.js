const http = require("http");
const os = require("os");
const mp = require("@metaparticle/package");

const port = 8080;

const server = http.createServer((req, resp) => {
    console.log(req.url);
    resp.end(`Hello World: hostname: ${os.hostname}\n`);
});

mp.containerize(
    {
        repository: "docker.io/smartpcr"
    },
    () => {
        server.listen(port, err => {
            if (err) {
                return console.log("server startup error: " + err);
            }
            console.log(`server up on ${port}`);
        })
    }
);
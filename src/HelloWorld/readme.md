# setup 

1. docker 
```bash
cd src/HelloWorld
docker build -t kubia .
docker run --name kubia-container -p 8001:8001 -d kubia

echo "run inside container"
docker exec -it kubia-container bash
ps aux
ps aux | grep app.js
exit
docker stop kubia-container
docker rm kubia-container

echo "pushing image"
docker tag kubia smartpcr/kubia
docker images | head
docker login -u smartpcr 
docker push smartpcr/kubia
docker run --name kubia-container -d smartpcr/kubia -p = 8001:8001
docker ps
docker stop kubia-container
docker rm kubia-container

echo "cleanup...."
docker stop kubia-container
docker rm kubia-container
docker rmi kubia
```
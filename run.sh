# build image
docker build -f Dockerfile -t jenkins-docker .

# run Jenkins
docker run \
    --name jenkins-docker \
    -p 8080:8080 \
    -v /var/run/docker.sock:/var/run/docker.sock \
    jenkins-docker

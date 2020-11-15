docker rm --force rhks-docker
docker run --publish 8081:8080 \
           --detach \
           --name rhks-docker rhks-docker:1
           # setting JAVA_OPTS causes error at start up
#          --env JAVA_OPTS='-Xms256m -Xmx1G -XX:MaxMetaspaceSize=256m' \
#docker logs rhks-docker 2>&1 | lnav -t
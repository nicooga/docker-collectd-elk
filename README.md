# Docker Host & Container Monitoring

This is the source for `redmatter/collectd-elk` docker image. It facilitates the collection of docker statistics into ELK stack.

# How to use it?

If you already have a functional ELK stack, you just need to run the container by mapping `logstash` (hostname) to the `LOGSTASH_IP`. If you use the docker-compose.yml, you can pass that in on the commandline as below.

    docker-compose up -d -e LOGSTASH_IP=x.x.x.x

If you do not have a functional ELK stack, you can have a look at https://github.com/redmatter/docker-elk.

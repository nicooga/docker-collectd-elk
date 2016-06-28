# Docker Host & Container Monitoring

This is the source for `redmatter/collectd-elk` docker image. It facilitates the collection of docker statistics into ELK stack.

# How to use it?

If you already have a functional ELK stack, you just need to run the container by mapping `logstash` (hostname) to the `LOGSTASH_IP`. If you use the docker-compose.yml, you can pass that in on the commandline as below.

    export LOGSTASH_NETWORK=<network-name>
    docker-compose up -d

For use in development environment an ELK stack can be deployed using the [`redmatter/docker-elk`](https://github.com/redmatter/docker-elk) project.

Here the network name to be defined in `LOGSTASH_NETWORK` would be `dockerelk_logstash` by default. Use `docker network ls` to find out the exact name.

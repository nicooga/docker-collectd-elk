# Docker Host & Container Monitoring

This is the source for `redmatter/collectd-elk` docker image. It facilitates the collection of docker statistics into
ELK stack.

# How to use it?

Th prerequisite to using this would be to have a functional ELK stack. For use in development environment an ELK stack
can be deployed using the [`redmatter/docker-elk`](https://github.com/redmatter/docker-elk) project. Once deployed, use
the commands below to deploy the `collectd-elk` container.

    export LOGSTASH_NETWORK=<network-name>
    docker-compose up -d

Here the network name to be defined in `LOGSTASH_NETWORK` would be `dockerelk_logstash` by default. Use 
`docker network ls` to find out the exact name.

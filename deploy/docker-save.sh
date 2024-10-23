#!/bin/sh

docker save aimosphere/airo | gzip > airo.tar.gz
docker save aimosphere/wingman | gzip > wingman.tar.gz
docker save aimosphere/chain-health | gzip > chain-health.tar.gz
docker save cog-health-client | gzip > cog-health-client.tar.gz
docker save cog-health-server | gzip > cog-health-server.tar.gz
docker save cog-hello-world | gzip > cog-hello-world.tar.gz
docker save cog-resnet | gzip > cog-resnet.tar.gz


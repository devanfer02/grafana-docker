#!/bin/bash

desired_content=$'{
    "log-driver": "loki",
    "log-opts": {
      "mode":"non-blocking",
      "loki-url": "http://localhost:3100/loki/api/v1/push", 
      "loki-batch-size": "400",
      "loki-retries": "2",
      "loki-max-backoff":"800ms",
      "loki-timeout":"1s"
    }
}'

if [ -z "$(docker plugin ls | grep loki:latest)" ]; then 
    echo "Docker loki plugin is not installed yet"
    echo "Installing docker loki plugin..."
    docker plugin install grafana/loki-docker-driver:2.9.1 --alias loki --grant-all-permissions
fi 

if [[ "$(sudo cat /etc/docker/daemon.json)" != "$desired_content" ]]; then 
    echo "$desired_content" | sudo tee /etc/docker/daemon.json > /dev/null  
    echo "File daemon.json updated"
    read -p "Do you wish to restart docker? (y/n) " choice
    echo "$choice"

    if [ "$choice" == "y" ]; then 
        echo 'Restarting docker service...'
        sudo systemctl restart docker
    fi 
fi

echo 'Spinning up the containers...'

docker compose up -d

docker container ls


# Grafana Setup with Docker

## 🚀 Getting Started

This docker compose configuration will setup grafana with prometheus that collects metrics from node_exporter and cadvisor and also loki with promtail. It will also provide 2 template dashboards. You can also provide more dashboards by adding the dashboard json files in [grafana/dashboards](./grafana/dashboards) directory or configure it by yourself in grafana dashboard.

What you need to setup all of this is just [docker](https://www.docker.com/) installed in your machine.

1. Install docker grafana/loki plugin.

```zsh
docker plugin install grafana/loki-docker-driver:2.9.1 --alias loki --grant-all-permissions
```

2. Configure docker daemon by editing ```/etc/docker/daemon.json``` file with below code.

NOTES: Beware of known issue: [Deadlocked Docker Daemon](https://github.com/grafana/loki/issues/2361) so make sure you didn't change the configuration below or you know your stuff

```json
{
    "log-driver": "loki",
    "log-opts": {
      "mode":"non-blocking",
      "loki-url": "http://localhost:3100/loki/api/v1/push", 
      "loki-batch-size": "400",
      "loki-retries": "2",
      "loki-max-backoff":"800ms",
      "loki-timeout":"1s"
    }
}
```

3. Restart docker service

```zsh
sudo systemctl restart docker
```

4. Finally, spin up the containers with below command and everything is already setup for you!

```zsh
docker compose up -d
```

## 🛠️ Tech Stacks

[![My Skills](https://skillicons.dev/icons?i=grafana,prometheus,docker)](https://skillicons.dev)

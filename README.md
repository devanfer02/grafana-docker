# Grafana Setup with Docker

## 🚀 Getting Started

Honestly, you just need docker to setup monitoring with grafana. It's not that hard actually but im still exploring grafana tho.

1. Configure the needed variables in [prometheus.yml](./prometheus.yml) 
2. If you want to guard prometheus with basic auth, you can setup the [web.yml](./web.yml) file. Otherwise just comment the command section in prometheus service in [docker-compose.yml](./docker-compose.yml)
3. After all that, just spin up the containers with 

```zsh
docker compose up -d
```

4. If the containers (grafana, prometheus, node_exporter) already running, visit [localhost:3000](localhost:3000) or use ```{ip_address:3000}``` and login with username: admin and password: admin

5. Add prometheus as your datasource in grafana dashboard and you can build your own dashboard or exploring dashboard templates like node exporter full, docker monitoring etc.
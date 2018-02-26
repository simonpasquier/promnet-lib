local prometheus = import "promnet/prometheus.libsonnet";
local kubernetes = import "promnet/kubernetes.libsonnet";

local conf = prometheus.setGlobal(
    "10s",
    "20s",
    "30s",
    {"dc": "eu-west-1"}
);

conf.addScrapeConfig(
    kubernetes.newServiceMonitor(
        "example-app",
        "myproject",
        {"app": "example", "env": "prod"},
    )
)

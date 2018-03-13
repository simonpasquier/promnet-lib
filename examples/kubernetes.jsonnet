// Minimalistic configuration
local prometheus = import "promnet/prometheus.libsonnet";
local scrape_config = prometheus.scrape_config;
local kubernetes_sd = prometheus.kubernetes_sd;

local conf = prometheus.setGlobal(
    "10s",
    "20s",
    "30s",
    {"dc": "eu-west-1"}
);

conf.addScrapeConfig(
    scrape_config.new(
        "kubernetes_nodes",
    )
    .addKubernetesSd(
        kubernetes_sd.new("node"),
    )
).addScrapeConfig(
    scrape_config.new(
        "kubernetes_endpoints",
    )
    .addKubernetesSd(
        kubernetes_sd.new("endpoints"),
    )
).addRule("rules/*.yml")

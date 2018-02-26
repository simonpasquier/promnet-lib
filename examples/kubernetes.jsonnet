local prometheus = import "promnet/prometheus.libsonnet";
local scrape_config = prometheus.scrape_config;
local kubernetes_sd = prometheus.kubernetes_sd;

prometheus.new(
    "12s",
)
.addScrapeConfig(
    scrape_config.new(
        "kubernetes_nodes",
    )
    .addKubernetesSd(
        kubernetes_sd.new("node"),
    )
)

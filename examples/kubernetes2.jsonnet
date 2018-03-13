// More complex configuration using mixins
local prometheus = import "promnet/prometheus.libsonnet";
local alerting = import "promnet/alerting.libsonnet";
local kubernetes = import "promnet/kubernetes.libsonnet";
local kubernetes_sd = import "promnet/kubernetes_sd.libsonnet";
local static_sd = import "promnet/static_config.libsonnet";
local relabel = import "promnet/relabel_config.libsonnet";

local conf = prometheus.setGlobal(
    "10s",
    "5s",
    "30s",
    {"dc": "eu-west-1"}
);
local am_sd = kubernetes_sd.new("endpoints", "monitoring");
local am_relabeling = [relabel.newKeep("__meta_kubernetes_service_name", "alertmanager")];

// This is the base configuration for Prometheus and AlertManager
conf.addScrapeConfig(
    prometheus.scrape_config.new(
        "prometheus",
    )
    .addStaticConfig(
        static_sd.new(["localhost:9090"]),
    ),
)
.addScrapeConfig(
    prometheus.scrape_config.new(
        "alertmanager",
    )
    .addKubernetesSd(
        am_sd
    )
    .addRelabelConfig(
        am_relabeling
    ),
)
.addRule(
    "prometheus_alerts.yaml"
)
.addAlertManager(
    alerting.newAlertManager(
        "10s"
    )
    .addKubernetesSd(
        am_sd
    )
    .addRelabelConfig(
        am_relabeling
    ),
)

+

// Configuration for scraping the kubelets
prometheus.scrapeConfigs(
    prometheus.scrape_config.new(
        "kubernetes_nodes",
    )
    .addKubernetesSd(
        kubernetes_sd.new("node"),
    ),
)

+

prometheus.rules(
    "node_alerts.yaml"
)

+

// Configuration for scraping endpoints labeled with app="example" and env="prod"
prometheus.scrapeConfigs(
    kubernetes.newServiceMonitor(
        "example-app",
        "myproject",
        {"app": "example", "env": "prod"},
    ),
)

+

// Additional rules for the example app
prometheus.rules(
    "example_alerts.yaml",
)

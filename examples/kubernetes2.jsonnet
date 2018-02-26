local prometheus = import "promnet/prometheus.libsonnet";
local alerting = import "promnet/alerting.libsonnet";
local kubernetes = import "promnet/kubernetes.libsonnet";
local kubernetes_sd = import "promnet/kubernetes_sd.libsonnet";
local relabel = import "promnet/relabel_config.libsonnet";

local conf = prometheus.setGlobal(
    "10s",
    "5s",
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
.addAlertManager(
    alerting.newAlertManager(
        "10s"
    )
    .addKubernetesSd(
        kubernetes_sd.new(
            "endpoints",
            "monitoring",
        ),
    )
    .addRelabelConfig(
        relabel.newKeep(
            "__meta_kubernetes_service_name",
            "alertmanager",
        ),
    ),
)

{
    new(
        job_name,
        honor_labels=false,
    ):: {
        job_name: job_name,
        honor_labels: honor_labels,
        kubernetes_sd_configs: [],
        static_configs: [],
        relabel_configs: [],
        metric_relabel_configs: [],
        addKubernetesSd(sd):: self {
            kubernetes_sd_configs+: [sd],
        },
        addStaticConfig(cfg):: self {
            static_configs+: [cfg],
        },
        addMetricRelabelConfig(cfg):: self {
            metric_relabel_configs+: (if std.type(cfg) == "array" then cfg else [cfg]),
        },
        addRelabelConfig(cfg):: self {
            relabel_configs+: (if std.type(cfg) == "array" then cfg else [cfg]),
        },
    },
}

{
    newAlertManager(timeout):: {
        [if timeout != null then "timeout"]: timeout,

        kubernetes_sd_configs: [],
        addKubernetesSd(sd):: self {
            kubernetes_sd_configs+: [sd],
        },

        static_configs: [],
        addStaticConfig(cfg):: self {
            static_configs+: [cfg],
        },

        relabel_configs: [],
        addRelabelConfig(cfg):: self {
            relabel_configs+: (if std.type(cfg) == "array" then cfg else [cfg]),
        },
    },
}


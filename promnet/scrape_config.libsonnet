{
    new(
        job_name,
        honor_labels=false,
    ):: {
        job_name: job_name,
        honor_labels: honor_labels,
        kubernetes_sd_configs: [],
        addKubernetesSd(sd):: self {
            kubernetes_sd_configs+: [sd],
        },
    },
}

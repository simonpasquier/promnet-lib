{
    new(
        job_name,
    ):: {
        job_name: job_name,
        kubernetes_sd_configs: [],
        addKubernetesSd(kubernetes_sd):: self {
            kubernetes_sd_configs+: [kubernetes_sd],
        },
    },
}

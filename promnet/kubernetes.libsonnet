local kubernetes_sd = import "kubernetes_sd.libsonnet";
local scrape_config = import "scrape_config.libsonnet";
local relabel_config = import "relabel_config.libsonnet";

{
    newServiceMonitor(
        name,
        namespace,
        selector={},
    ):: scrape_config.new(
            name
        )
        .addKubernetesSd(
            kubernetes_sd.new(
                "endpoints",
                namespace
            )
        )
        .addRelabelConfig(
            [ relabel_config.newKeep('__meta_kubernetes_service_label_' + k, selector[k]) for k in std.objectFields(selector) ],
        ),
}

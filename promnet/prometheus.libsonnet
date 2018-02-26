{
    kubernetes_sd:: import "kubernetes_sd.libsonnet",
    scrape_config:: import "scrape_config.libsonnet",

    new(
        scrape_interval=null,
        scrape_timeout=null,
        evaluation_interval=null,
        external_labels={},
        rule_files=[],
    ):: {
        local it = self,
        _scrape_configs:: [],
        addScrapeConfig(scrape_config):: self {
            _scrape_configs+:: [scrape_config],
        },
        scrape_configs: it._scrape_configs,
        global: {
            [if scrape_interval != null then "scrape_interval"]: scrape_interval,
            [if scrape_timeout != null then "scrape_timeout"]: scrape_timeout,
            [if evaluation_interval != null then "evaluation_interval"]: evaluation_interval,
            external_labels: external_labels,
        },
        rule_files: rule_files,
    }
}

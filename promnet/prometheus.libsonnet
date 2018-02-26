{
    kubernetes_sd:: import "kubernetes_sd.libsonnet",
    scrape_config:: import "scrape_config.libsonnet",

    _global:: {},
    _rules:: [],
    _scrape_configs:: [],

    addRule(
        rule,
    ):: self {
        _rules+:: [rule],
    },
    rules: self._rules,

    addScrapeConfig(
        scrape_config,
    ):: self {
        _scrape_configs+:: [scrape_config],
    },
    scrape_configs: self._scrape_configs,

    setGlobal(
        scrape_interval=null,
        scrape_timeout=null,
        evaluation_interval=null,
        external_labels={},
    ):: self {
        _global:: {
            [if scrape_interval != null then "scrape_interval"]: scrape_interval,
            [if scrape_timeout != null then "scrape_timeout"]: scrape_timeout,
            [if evaluation_interval != null then "evaluation_interval"]: evaluation_interval,
            external_labels: external_labels,
        },
    },
    global: self._global
}

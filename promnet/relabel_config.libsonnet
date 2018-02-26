{
    newReplace(
        sources,
        target,
        separator=null,
        regex=null,
        replacement=null,
    ):: {
        action: "replace",
        source_labels: sources,
        target_label: target,
        [if separator != null then "separator"]: separator,
        [if regex != null then "regex"]: regex,
        [if replacement != null then "replacement"]: replacement,
    },

    newLabelMap(
        target,
        separator=null,
        regex=null,
        replacement=null,
    ):: {
        action: "labelmap",
        target_label: target,
        [if separator != null then "separator"]: separator,
        [if regex != null then "regex"]: regex,
        [if replacement != null then "replacement"]: replacement,
    },

    newFilter(
        source_labels,
        regex,
        drop,
    ):: {
        action: (if drop then "drop" else "keep"),
        source_labels: (if std.type(source_labels) == "array" then source_labels else [source_labels]),
        regex: regex,
    },
    newKeep(
        source_labels,
        regex,
    ):: self.newFilter(source_labels, regex, false),
    newDrop(
        source_labels,
        regex,
    ):: self.newFilter(source_labels, regex, true),

    newLabelFilter(
        source_labels,
        regex,
        drop,
    ):: {
        action: (if drop then "labeldrop" else "labelkeep"),
        source_labels: (if std.type(source_labels) == "array" then source_labels else [source_labels]),
        regex: regex,
    },
    newLabelDrop(
        source_labels,
        regex,
    ):: self.newLabelFilter(source_labels, regex, true),
    newLabelKeep(
        source_labels,
        regex,
    ):: self.newLabelFilter(source_labels, regex, false),
}


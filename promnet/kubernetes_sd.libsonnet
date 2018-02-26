{
    new(
        role,
        namespaces=null,
    ):: {
        role: role,
        namespaces: {
            [if namespaces != null then "names"]: (if std.type(namespaces) == "array" then namespaces else [namespaces]),
        },
    },
}

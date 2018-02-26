{
    new(
        role,
        namespaces=null,
    ):: {
        role: role,
        namespaces: {
            names: namespaces,
        },
    },
}

{{/*
Runtime namespace selector
*/}}
{{- define "kyverno.runtime.namespaceSelector" -}}
namespaceSelector:
  matchLabels:
    security.microbank.io/profile: restricted
{{- end }}

{{/*
Platform namespaces
*/}}
{{- define "kyverno.namespace.platform" -}}
namespaceSelector:
  matchLabels:
    security.microbank.io/profile: platform
{{- end }}
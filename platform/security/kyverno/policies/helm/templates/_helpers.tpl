{{/*
Runtime namespace selector
*/}}
{{- define "kyverno.runtime.namespaceSelector" -}}
namespaceSelector:
  matchLabels:
    security.microbank.io/profile: restricted
{{- end }}
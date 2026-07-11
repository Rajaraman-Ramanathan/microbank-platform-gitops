{{/*
Metadata Policy Name
*/}}
{{- define "kyverno.metadata.policyName" -}}
{{ .Values.metadata.policy.name }}
{{- end }}
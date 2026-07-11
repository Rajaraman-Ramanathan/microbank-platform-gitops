{{/*
Container Security Policy Name
*/}}

{{- define "kyverno.containers.policyName" -}}
{{ .Values.containers.policy.name }}
{{- end }}
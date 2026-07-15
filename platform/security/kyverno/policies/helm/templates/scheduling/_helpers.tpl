{{/*
Scheduling Policy Name
*/}}
{{- define "kyverno.scheduling.policyName" -}}
{{ .Values.scheduling.policy.name }}
{{- end }}
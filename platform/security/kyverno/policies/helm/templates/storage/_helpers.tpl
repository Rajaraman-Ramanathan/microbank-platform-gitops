{{/*
Storage Policy Name
*/}}
{{- define "kyverno.storage.policyName" -}}
{{ .Values.storage.policy.name }}
{{- end }}
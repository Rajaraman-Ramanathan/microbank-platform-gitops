{{/*
Secret Policy Name
*/}}
{{- define "kyverno.secrets.policyName" -}}
{{ .Values.secrets.policy.name }}
{{- end }}
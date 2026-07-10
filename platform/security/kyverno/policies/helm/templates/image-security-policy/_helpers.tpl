{{/*
Image Security Policy Name
*/}}

{{- define "kyverno.imageSecurity.policyName" -}}
{{ .Values.imageSecurity.policy.name }}
{{- end }}
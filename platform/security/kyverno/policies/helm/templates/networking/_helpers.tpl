{{/*
Networking Policy Name
*/}}
{{- define "kyverno.networking.policyName" -}}
{{ .Values.networking.policy.name }}
{{- end }}
{{/*
Pod Security ClusterPolicy
*/}}

{{- define "kyverno.podSecurity.policyName" -}}
{{ .Values.podSecurity.policy.name }}
{{- end }}
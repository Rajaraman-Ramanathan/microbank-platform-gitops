{{/*
Probe Policy Name
*/}}
{{- define "kyverno.probes.policyName" -}}
{{ .Values.probes.policy.name }}
{{- end }}
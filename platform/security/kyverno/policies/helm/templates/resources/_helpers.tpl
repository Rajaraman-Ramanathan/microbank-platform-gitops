{{- define "kyverno.resources.policyName" -}}
{{ .Values.resources.policy.name }}
{{- end }}
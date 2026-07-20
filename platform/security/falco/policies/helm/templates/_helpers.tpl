{{/*
Expand chart name.
*/}}
{{- define "microbank-falco-rules.name" -}}
{{- default .Chart.Name .Values.nameOverride }}
{{- end }}

{{/*
Full name.
*/}}
{{- define "microbank-falco-rules.fullname" -}}
{{- printf "%s" (include "microbank-falco-rules.name" .) }}
{{- end }}

{{/*
Common labels.
*/}}
{{- define "microbank-falco-rules.labels" -}}
app.kubernetes.io/name: {{ include "microbank-falco-rules.name" . }}
app.kubernetes.io/version: {{ .Chart.AppVersion }}
helm.sh/chart: {{ .Chart.Name }}-{{ .Chart.Version }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}
{{/*
------------------------------------------------------------------------------
Chart Name
------------------------------------------------------------------------------
*/}}
{{- define "microbank-falco-rules.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" -}}
{{- end }}

{{/*
------------------------------------------------------------------------------
Full Name
------------------------------------------------------------------------------
*/}}
{{- define "microbank-falco-rules.fullname" -}}
{{- if .Values.fullnameOverride -}}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- printf "%s-%s" .Release.Name (include "microbank-falco-rules.name" .) | trunc 63 | trimSuffix "-" -}}
{{- end -}}
{{- end }}

{{/*
------------------------------------------------------------------------------
Chart
------------------------------------------------------------------------------
*/}}
{{- define "microbank-falco-rules.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" -}}
{{- end }}

{{/*
------------------------------------------------------------------------------
Labels
------------------------------------------------------------------------------
*/}}
{{- define "microbank-falco-rules.labels" -}}
helm.sh/chart: {{ include "microbank-falco-rules.chart" . }}
app.kubernetes.io/name: {{ include "microbank-falco-rules.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
------------------------------------------------------------------------------
Load all Falco rule files from a directory.

Usage:
{{ include "microbank-falco-rules.ruleGroup" (list . "rules/process/*.yaml") }}

------------------------------------------------------------------------------
*/}}
{{- define "microbank-falco-rules.ruleGroup" -}}
{{- $root := index . 0 -}}
{{- $pattern := index . 1 -}}
{{- range $path, $_ := $root.Files.Glob $pattern }}
  {{ base $path }}: |
{{ $root.Files.Get $path | indent 4 }}
{{- end }}
{{- end }}
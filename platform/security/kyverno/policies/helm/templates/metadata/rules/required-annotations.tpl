{{- define "kyverno.metadata.rule.requiredAnnotations" }}
{{- if .Values.metadata.requiredAnnotations.enabled }}
- name: require-organization-annotations
  match:
    any:
      - resources:
          kinds:
            - Pod
{{ include "kyverno.runtime.namespaceSelector" . | nindent 10 }}
  validate:
    message: All workloads must define the required organization annotations.
    pattern:
      metadata:
        annotations:
{{- range .Values.metadata.requiredAnnotations.annotations }}
          =({{ . }}): "?*"
{{- end }}
{{- end }}
{{- end }}
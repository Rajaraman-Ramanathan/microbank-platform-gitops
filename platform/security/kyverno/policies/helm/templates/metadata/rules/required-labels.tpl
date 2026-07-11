{{- define "kyverno.metadata.rule.requiredLabels" }}
{{- if .Values.metadata.requiredLabels.enabled }}
- name: require-kubernetes-standard-labels
  match:
    any:
      - resources:
          kinds:
            - Pod
{{ include "kyverno.runtime.namespaceSelector" . | nindent 10 }}
  validate:
    message: All workloads must define the required Kubernetes application labels.
    pattern:
      metadata:
        labels:
{{- range .Values.metadata.requiredLabels.labels }}
          =({{ . }}): "?*"
{{- end }}
{{- end }}
{{- end }}
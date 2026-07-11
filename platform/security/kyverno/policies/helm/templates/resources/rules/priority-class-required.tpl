{{- define "kyverno.resources.rule.priorityClassRequired" }}
{{- if .Values.resources.priorityClassRequired.enabled }}
- name: require-priority-class
  match:
    any:
      - resources:
          kinds:
            - Pod
{{ include "kyverno.runtime.namespaceSelector" . | nindent 10 }}            
  validate:
    message: Pods must specify a priorityClassName.
    pattern:
      spec:
        priorityClassName: "?*"
{{- end }}
{{- end }}
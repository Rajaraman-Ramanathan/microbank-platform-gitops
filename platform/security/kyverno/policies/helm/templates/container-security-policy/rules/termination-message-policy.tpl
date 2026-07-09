{{- define "kyverno.containers.rule.terminationMessagePolicy" }}
{{- if .Values.containers.terminationMessagePolicy.enabled }}
- name: require-termination-message-policy
  match:
    any:
      - resources:
          kinds:
            - Pod
  validate:
    message: Containers must explicitly define terminationMessagePolicy.
    foreach:
      - list: request.object.spec.containers
        pattern:
          terminationMessagePolicy: {{ .Values.containers.terminationMessagePolicy.requiredValue }}
{{- end }}
{{- end }}
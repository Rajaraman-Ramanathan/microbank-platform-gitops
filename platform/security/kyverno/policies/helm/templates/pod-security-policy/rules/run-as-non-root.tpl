{{- define "kyverno.podSecurity.rule.runAsNonRoot" }}
{{- if .Values.podSecurity.runAsNonRoot.enabled }}
- name: require-run-as-non-root
  match:
    any:
      - resources:
          kinds:
            - Pod
  validate:
    message: Containers must run as a non-root user.
    foreach:
      - list: request.object.spec.containers
        pattern:
          securityContext:
            runAsNonRoot: true
{{- end }}
{{- end }}
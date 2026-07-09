{{- define "kyverno.podSecurity.rule.readOnlyRootFilesystem" }}
{{- if .Values.podSecurity.readOnlyRootFilesystem.enabled }}
- name: require-read-only-root-filesystem
  match:
    any:
      - resources:
          kinds:
            - Pod
  validate:
    message: Containers must use a read-only root filesystem.
    foreach:
      - list: request.object.spec.containers
        pattern:
          securityContext:
            readOnlyRootFilesystem: true
{{- end }}
{{- end }}
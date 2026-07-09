{{- define "kyverno.podSecurity.rule.seccomp" }}
{{- if .Values.podSecurity.seccomp.enabled }}
- name: require-seccomp-profile
  match:
    any:
      - resources:
          kinds:
            - Pod
  validate:
    message: Containers must use RuntimeDefault seccomp profile.
    foreach:
      - list: request.object.spec.containers
        pattern:
          securityContext:
            seccompProfile:
              type: {{ .Values.podSecurity.seccomp.requiredProfile }}
{{- end }}
{{- end }}
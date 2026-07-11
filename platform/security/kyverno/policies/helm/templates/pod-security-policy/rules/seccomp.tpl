{{- define "kyverno.podSecurity.rule.seccomp" }}
{{- if .Values.podSecurity.seccomp.enabled }}
- name: require-seccomp-profile
  match:
    any:
      - resources:
          kinds:
            - Pod
{{ include "kyverno.runtime.namespaceSelector" . | nindent 10 }}            
  validate:
    message: All containers and init containers must use the RuntimeDefault seccomp profile.
    foreach:
      - list: request.object.spec.containers
        pattern:
          =(securityContext):
            =(seccompProfile):
              =(type): {{ .Values.podSecurity.seccomp.requiredProfile }}
      - list: request.object.spec.initContainers || []
        pattern:
          =(securityContext):
            =(seccompProfile):
              =(type): {{ .Values.podSecurity.seccomp.requiredProfile }}
{{- end }}
{{- end }}
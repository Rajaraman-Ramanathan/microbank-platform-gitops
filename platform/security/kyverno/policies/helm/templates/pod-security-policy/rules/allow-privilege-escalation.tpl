{{- define "kyverno.podSecurity.rule.allowPrivilegeEscalation" }}
{{- if .Values.podSecurity.allowPrivilegeEscalation.enabled }}
- name: disallow-privilege-escalation
  match:
    any:
      - resources:
          kinds:
            - Pod
{{ include "kyverno.runtime.namespaceSelector" . | nindent 10 }}            
  validate:
    message: Privilege escalation is prohibited in containers and initcontainers.
    foreach:
      - list: request.object.spec.containers
        pattern:
          =(securityContext):
            =(allowPrivilegeEscalation): false
      - list: request.object.spec.initContainers || []
        pattern:
          =(securityContext):
            =(allowPrivilegeEscalation): false
{{- end }}
{{- end }}
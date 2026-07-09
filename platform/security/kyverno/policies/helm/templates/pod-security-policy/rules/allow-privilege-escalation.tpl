{{- define "kyverno.podSecurity.rule.allowPrivilegeEscalation" }}
{{- if .Values.podSecurity.allowPrivilegeEscalation.enabled }}
- name: disallow-privilege-escalation
  match:
    any:
      - resources:
          kinds:
            - Pod
  validate:
    message: Privilege escalation is prohibited.
    foreach:
      - list: request.object.spec.containers
        pattern:
          securityContext:
            allowPrivilegeEscalation: false
{{- end }}
{{- end }}
{{- define "kyverno.containers.rule.initContainers" }}
{{- if .Values.containers.initContainers.enabled }}
- name: validate-init-container-security
  match:
    any:
      - resources:
          kinds:
            - Pod
  preconditions:
    all:
      - key: "{{ "{{ request.object.spec.initContainers[] || '' }}" }}"
        operator: NotEquals
        value: ""
  validate:
    message: Init containers must follow the same security standards as application containers.
    foreach:
      - list: request.object.spec.initContainers
        pattern:
          securityContext:
            runAsNonRoot: true
            allowPrivilegeEscalation: false
{{- end }}
{{- end }}
{{- define "kyverno.podSecurity.rule.capabilities" }}
{{- if .Values.podSecurity.capabilities.enabled }}
- name: require-capability-drop
  match:
    any:
      - resources:
          kinds:
            - Pod
  validate:
    message: Containers must drop all Linux capabilities.
    foreach:
      - list: request.object.spec.containers
        pattern:
          securityContext:
            capabilities:
              drop:
              {{- range .Values.podSecurity.capabilities.requiredDropCapabilities }}
                - {{ . }}
              {{- end }}
{{- end }}
{{- end }}
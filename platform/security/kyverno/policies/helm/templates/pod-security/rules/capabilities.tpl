{{- define "kyverno.podSecurity.rule.capabilities" }}
{{- if .Values.podSecurity.capabilities.enabled }}
- name: require-capability-drop
  match:
    any:
      - resources:
          kinds:
            - Pod
{{ include "kyverno.runtime.namespaceSelector" . | nindent 10 }}            
  validate:
    message: Containers and initcontainers must drop all Linux capabilities.
    foreach:
      - list: request.object.spec.containers
        pattern:
          =(securityContext):
            =(capabilities):
              =(drop):
              {{- range .Values.podSecurity.capabilities.requiredDropCapabilities }}
                - {{ . }}
              {{- end }}
      - list: request.object.spec.initContainers || []
        pattern:
          =(securityContext):
            =(capabilities):
              =(drop):
              {{- range .Values.podSecurity.capabilities.requiredDropCapabilities }}
                - {{ . }}
              {{- end }}
{{- end }}
{{- end }}
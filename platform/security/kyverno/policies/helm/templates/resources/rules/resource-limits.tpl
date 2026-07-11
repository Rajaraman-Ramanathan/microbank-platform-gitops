{{- define "kyverno.resources.rule.resourceLimits" }}
{{- if .Values.resources.resourceLimits.enabled }}
- name: require-resource-limits
  match:
    any:
      - resources:
          kinds:
            - Pod
{{ include "kyverno.runtime.namespaceSelector" . | nindent 10 }}            
  validate:
    message: All containers and init containers must define CPU and memory resource limits.
    foreach:
      #
      # Application Containers
      #
      - list: request.object.spec.containers
        pattern:
          =(resources):
            =(limits):
              cpu: "?*"
              memory: "?*"
      #
      # Init Containers
      #
      - list: request.object.spec.initContainers || []
        pattern:
          =(resources):
            =(limits):
              cpu: "?*"
              memory: "?*"
{{- end }}
{{- end }}
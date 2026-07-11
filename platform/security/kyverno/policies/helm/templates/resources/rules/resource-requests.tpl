{{- define "kyverno.resources.rule.resourceRequests" }}
{{- if .Values.resources.resourceRequests.enabled }}
- name: require-resource-requests
  match:
    any:
      - resources:
          kinds:
            - Pod
{{ include "kyverno.runtime.namespaceSelector" . | nindent 10 }}            
  validate:
    message: All containers and init containers must define CPU and memory resource requests.
    foreach:
      #
      # Application Containers
      #
      - list: request.object.spec.containers
        pattern:
          =(resources):
            =(requests):
              cpu: "?*"
              memory: "?*"
      #
      # Init Containers
      #
      - list: request.object.spec.initContainers || []
        pattern:
          =(resources):
            =(requests):
              cpu: "?*"
              memory: "?*"
{{- end }}
{{- end }}
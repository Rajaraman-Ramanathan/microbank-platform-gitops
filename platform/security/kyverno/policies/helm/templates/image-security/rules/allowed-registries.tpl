{{- define "kyverno.imageSecurity.rule.allowedRegistries" }}
{{- if .Values.imageSecurity.allowedRegistries.enabled }}
- name: require-approved-image-registry
  match:
    any:
      - resources:
          kinds:
            - Pod
{{ include "kyverno.runtime.namespaceSelector" . | nindent 10 }}            
  validate:
    cel:
      variables:
        # Merges standard, initialization, and ephemeral containers cleanly using CEL
        - name: allContainers
          expression: "object.spec.containers + object.spec.?initContainers.orValue([]) + object.spec.?ephemeralContainers.orValue([])"
      expressions:
        - expression: >-
            variables.allContainers.all(container, 
              {{- $registries := .Values.imageSecurity.allowedRegistries.registries }}
              {{- range $index, $registry := $registries }}
              container.image.startsWith('{{ $registry }}'){{ if ne (add1 $index) (len $registries) }} ||{{ end }}
              {{- end }}
            )
          message: "Validation failed: One or more containers are pulling from an unapproved image registry."
{{- end }}
{{- end }}

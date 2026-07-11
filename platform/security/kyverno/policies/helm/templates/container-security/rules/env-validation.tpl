{{- define "kyverno.containers.rule.envValidation" }}
{{- if .Values.containers.envValidation.enabled }}
- name: prohibit-hardcoded-sensitive-environment-variables
  match:
    any:
      - resources:
          kinds:
            - Pod
{{ include "kyverno.runtime.namespaceSelector" . | nindent 10 }}            
  validate:
    message: Sensitive environment variables must be sourced from Kubernetes Secrets or External Secrets.
    foreach:
      - list: request.object.spec.containers[].env[] || []
        deny:
          conditions:
            all:
              - key: "{{ "{{ element.name }}" }}"
                operator: AnyIn
                value:
{{ toYaml .Values.containers.envValidation.sensitiveVariables | indent 18 }}
              - key: "{{ "{{ element.value }}" }}"
                operator: NotEquals
                value: null
      - list: request.object.spec.initContainers[].env || []
        deny:
          conditions:
            all:
              - key: "{{ "{{ element.name }}" }}"
                operator: AnyIn
                value:
{{ toYaml .Values.containers.envValidation.sensitiveVariables | indent 18 }}
              - key: "{{ "{{ element.value }}" }}"
                operator: NotEquals
                value: null
{{- end }}
{{- end }}
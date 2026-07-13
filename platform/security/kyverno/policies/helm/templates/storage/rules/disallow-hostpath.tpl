{{- define "kyverno.storage.rule.disallowHostPath" }}
{{- if .Values.storage.disallowHostPath.enabled }}
- name: disallow-hostpath-volumes
  match:
    any:
      - resources:
          kinds:
            - Pod
{{ include "kyverno.runtime.namespaceSelector" . | nindent 10 }}
  validate:
    message: HostPath volumes are prohibited.
    foreach:
      - list: request.object.spec.volumes || []
        deny:
          conditions:
            any:
              - key: "{{ "{{ element.hostPath }}" }}"
                operator: NotEquals
                value: null
{{- end }}
{{- end }}
{{- define "kyverno.networking.rule.restrictServiceTypes" }}
{{- if .Values.networking.serviceTypes.enabled }}
- name: restrict-service-types
  match:
    any:
      - resources:
          kinds:
            - Service
{{ include "kyverno.runtime.namespaceSelector" . | nindent 10 }}
  validate:
    message: Only approved Service types may be used.
    deny:
      conditions:
        any:
          - key: "{{ request.object.spec.type || 'ClusterIP' }}"
            operator: AnyNotIn
            value:
{{ toYaml .Values.networking.serviceTypes.allowed | indent 14 }}
{{- end }}
{{- end }}
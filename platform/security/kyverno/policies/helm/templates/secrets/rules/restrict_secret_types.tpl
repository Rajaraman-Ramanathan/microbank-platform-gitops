{{- define "kyverno.secrets.rule.restrictSecretTypes" }}
{{- if .Values.secrets.restrictSecretTypes.enabled }}
- name: restrict-secret-types
  match:
    any:
      - resources:
          kinds:
            - Secret
{{ include "kyverno.runtime.namespaceSelector" . | nindent 10 }}
  validate:
    message: Secret type is not permitted.
    pattern:
      type: "{{ .Values.secrets.restrictSecretTypes.allowed | first }}"
{{- end }}
{{- end }}
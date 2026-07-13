{{- define "kyverno.storage.rule.allowedAccessModes" }}
{{- if .Values.storage.allowedAccessModes.enabled }}
- name: restrict-access-modes
  match:
    any:
      - resources:
          kinds:
            - PersistentVolumeClaim
{{ include "kyverno.runtime.namespaceSelector" . | nindent 10 }}
  validate:
    message: Only approved access modes may be used.
    pattern:
      spec:
        =(accessModes):
{{- range .Values.storage.allowedAccessModes.allowed }}
          - {{ . }}
{{- end }}
{{- end }}
{{- end }}
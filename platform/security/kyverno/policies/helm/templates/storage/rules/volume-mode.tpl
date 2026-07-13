{{- define "kyverno.storage.rule.volumeMode" }}
{{- if .Values.storage.volumeMode.enabled }}
- name: require-filesystem-volume-mode
  match:
    any:
      - resources:
          kinds:
            - PersistentVolumeClaim
{{ include "kyverno.runtime.namespaceSelector" . | nindent 10 }}
  validate:
    message: PVCs must use the approved volume mode.
    pattern:
      spec:
        =(volumeMode): {{ .Values.storage.volumeMode.required }}
{{- end }}
{{- end }}
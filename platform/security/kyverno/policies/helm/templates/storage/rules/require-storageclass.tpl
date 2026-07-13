{{- define "kyverno.storage.rule.requireStorageClass" }}
{{- if .Values.storage.requireStorageClass.enabled }}
- name: require-storage-class
  match:
    any:
      - resources:
          kinds:
            - PersistentVolumeClaim
{{ include "kyverno.runtime.namespaceSelector" . | nindent 10 }}
  validate:
    message: PersistentVolumeClaims must explicitly define a storageClassName.
    pattern:
      spec:
        =(storageClassName): "?*"
{{- end }}
{{- end }}
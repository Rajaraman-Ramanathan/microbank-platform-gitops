{{- define "kyverno.networking.rule.hostNetwork" }}
{{- if .Values.networking.hostNetwork.enabled }}
- name: disallow-host-network
  match:
    any:
      - resources:
          kinds:
            - Pod
{{ include "kyverno.runtime.namespaceSelector" . | nindent 10 }}
  validate:
    message: hostNetwork must not be enabled.
    pattern:
      spec:
        =(hostNetwork): false
{{- end }}
{{- end }}
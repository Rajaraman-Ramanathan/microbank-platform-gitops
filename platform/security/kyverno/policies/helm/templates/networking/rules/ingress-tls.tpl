{{- define "kyverno.networking.rule.ingressTLS" }}
{{- if .Values.networking.ingressTLS.enabled }}
- name: require-ingress-tls
  match:
    any:
      - resources:
          kinds:
            - Ingress
{{ include "kyverno.runtime.namespaceSelector" . | nindent 10 }}
  validate:
    message: Every Ingress must configure TLS.
    pattern:
      spec:
        =(tls):
          - =(secretName): "?*"
{{- end }}
{{- end }}
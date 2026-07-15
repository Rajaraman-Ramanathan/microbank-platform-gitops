{{- define "kyverno.networking.rule.ingressClass" }}
{{- if .Values.networking.ingressClass.enabled }}
- name: restrict-ingress-class
  match:
    any:
      - resources:
          kinds:
            - Ingress
{{ include "kyverno.runtime.namespaceSelector" . | nindent 10 }}
  validate:
    message: Only approved ingress classes may be used.
    deny:
      conditions:
        any:
          - key: "{{ "{{ request.object.spec.ingressClassName || '' }}" }}"
            operator: AnyNotIn
            value:
{{ toYaml .Values.networking.ingressClass.allowed | indent 14 }}
{{- end }}
{{- end }}
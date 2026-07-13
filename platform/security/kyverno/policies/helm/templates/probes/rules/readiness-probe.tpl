{{- define "kyverno.probes.rule.readinessProbe" }}
{{- if .Values.probes.readiness.enabled }}
- name: require-readiness-probe
  match:
    any:
      - resources:
          kinds:
            - Pod
{{ include "kyverno.runtime.namespaceSelector" . | nindent 10 }}
  validate:
    message: All application containers must define a readiness probe.
    foreach:
      - list: request.object.spec.containers
        pattern:
          =(readinessProbe):
            =(initialDelaySeconds): "?*"
            =(periodSeconds): "?*"
{{- end }}
{{- end }}
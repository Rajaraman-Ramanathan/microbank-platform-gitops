{{- define "kyverno.probes.rule.livenessProbe" }}
{{- if .Values.probes.liveness.enabled }}
- name: require-liveness-probe
  match:
    any:
      - resources:
          kinds:
            - Pod
{{ include "kyverno.runtime.namespaceSelector" . | nindent 10 }}
  validate:
    message: All application containers must define a liveness probe.
    foreach:
      - list: request.object.spec.containers
        pattern:
          =(livenessProbe):
            =(initialDelaySeconds): "?*"
            =(periodSeconds): "?*"
{{- end }}
{{- end }}
{{- define "kyverno.probes.rule.startupProbe" }}
{{- if .Values.probes.startup.enabled }}
- name: require-startup-probe
  match:
    any:
      - resources:
          kinds:
            - Pod
{{ include "kyverno.runtime.namespaceSelector" . | nindent 10 }}
  validate:
    message: Startup probes are required.
    foreach:
      - list: request.object.spec.containers
        pattern:
          =(startupProbe):
            =(failureThreshold): "?*"
            =(periodSeconds): "?*"
{{- end }}
{{- end }}
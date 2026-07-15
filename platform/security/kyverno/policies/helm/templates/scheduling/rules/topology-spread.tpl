{{- define "kyverno.scheduling.rule.topologySpread" }}
{{- if .Values.scheduling.topologySpread.enabled }}
- name: require-topology-spread
  match:
    any:
      - resources:
          kinds:
            - Deployment
            - StatefulSet
{{ include "kyverno.runtime.namespaceSelector" . | nindent 10 }}
  preconditions:
    all:
      - key: "{{ "{{ request.object.spec.replicas || 1 }}" }}"
        operator: GreaterThan
        value: 1
  validate:
    message: Workloads must define topology spread constraints.
    pattern:
      spec:
        template:
          spec:
            =(topologySpreadConstraints): "?*"
{{- end }}
{{- end }}
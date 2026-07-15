{{- define "kyverno.scheduling.rule.podAntiAffinity" }}
{{- if .Values.scheduling.podAntiAffinity.enabled }}
- name: require-pod-anti-affinity
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
    message: Workloads must define pod anti-affinity rules.
    pattern:
      spec:
        template:
          spec:
            =(affinity):
              =(podAntiAffinity): "?*"
{{- end }}
{{- end }}
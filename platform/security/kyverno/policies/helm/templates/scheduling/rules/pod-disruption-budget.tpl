{{- define "kyverno.scheduling.rule.podDisruptionBudget" }}
{{- if .Values.scheduling.podDisruptionBudget.enabled }}
- name: require-pdb-availability-policy
  match:
    any:
      - resources:
          kinds:
            - PodDisruptionBudget
{{ include "kyverno.runtime.namespaceSelector" . | nindent 10 }}
  validate:
    message: PodDisruptionBudget must specify either minAvailable or maxUnavailable to define the disruption policy.
    deny:
    conditions:
      all:
        - key: "{{ "{{ request.object.spec.minAvailable }}" }}"
          operator: Equals
          value: null
        - key: "{{ "{{ request.object.spec.maxUnavailable }}" }}"
          operator: Equals
          value: null
{{- end }}
{{- end }}

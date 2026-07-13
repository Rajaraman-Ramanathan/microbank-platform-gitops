{{- define "kyverno.probes.rule.probeConfiguration" }}
{{- if .Values.probes.configuration.enabled }}
- name: validate-probe-configuration
  match:
    any:
      - resources:
          kinds:
            - Pod
{{ include "kyverno.runtime.namespaceSelector" . | nindent 10 }}
  validate:
    message: Probe timing values must comply with platform standards.
    foreach:
      #
      # Application Containers
      #
      - list: request.object.spec.containers
        deny:
          conditions:
            any:
              #
              # Liveness Probe
              #
              - key: "{{ "{{ element.livenessProbe.timeoutSeconds || 0 }}" }}"
                operator: LessThan
                value: {{ .Values.probes.configuration.timeout.min }}
              - key: "{{ "{{ element.livenessProbe.timeoutSeconds || 0 }}" }}"
                operator: GreaterThan
                value: {{ .Values.probes.configuration.timeout.max }}
              - key: "{{ "{{ element.livenessProbe.periodSeconds || 0 }}" }}"
                operator: LessThan
                value: {{ .Values.probes.configuration.period.min }}
              - key: "{{ "{{ element.livenessProbe.periodSeconds || 0 }}" }}"
                operator: GreaterThan
                value: {{ .Values.probes.configuration.period.max }}
              #
              # Readiness Probe
              #
              - key: "{{ "{{ element.readinessProbe.timeoutSeconds || 0 }}" }}"
                operator: LessThan
                value: {{ .Values.probes.configuration.timeout.min }}
              - key: "{{ "{{ element.readinessProbe.timeoutSeconds || 0 }}" }}"
                operator: GreaterThan
                value: {{ .Values.probes.configuration.timeout.max }}
              - key: "{{ "{{ element.readinessProbe.periodSeconds || 0 }}" }}"
                operator: LessThan
                value: {{ .Values.probes.configuration.period.min }}
              - key: "{{ "{{ element.readinessProbe.periodSeconds || 0 }}" }}"
                operator: GreaterThan
                value: {{ .Values.probes.configuration.period.max }}
{{- if .Values.probes.startup.enabled }}
              #
              # Startup Probe
              #
              - key: "{{ "{{ element.startupProbe.timeoutSeconds || 0 }}" }}"
                operator: LessThan
                value: {{ .Values.probes.configuration.timeout.min }}
              - key: "{{ "{{ element.startupProbe.timeoutSeconds || 0 }}" }}"
                operator: GreaterThan
                value: {{ .Values.probes.configuration.timeout.max }}
              - key: "{{ "{{ element.startupProbe.periodSeconds || 0 }}" }}"
                operator: LessThan
                value: {{ .Values.probes.configuration.period.min }}
              - key: "{{ "{{ element.startupProbe.periodSeconds || 0 }}" }}"
                operator: GreaterThan
                value: {{ .Values.probes.configuration.period.max }}
{{- end }}
{{- end }}
{{- end }}
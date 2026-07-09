{{- define "kyverno.containers.rule.containerPorts" }}
{{- if .Values.containers.containerPorts.enabled }}
- name: require-container-ports
  match:
    any:
      - resources:
          kinds:
            - Pod
  validate:
    message: Every application container must expose at least one containerPort.
    foreach:
      - list: request.object.spec.containers
        pattern:
          ports:
            - containerPort: "?*"
{{- end }}
{{- end }}
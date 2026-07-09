{{- define "kyverno.containers.rule.lifecycleHooks" }}
{{- if .Values.containers.lifecycleHooks.enabled }}
- name: validate-lifecycle-hooks
  match:
    any:
      - resources:
          kinds:
            - Pod
  validate:
    message: Lifecycle hooks must only use approved handler types.
    foreach:
      - list: request.object.spec.containers
        pattern:
          =(lifecycle):
            =(preStop):
              =(exec): "*"
            =(postStart):
              =(exec): "*"
{{- end }}
{{- end }}
{{- define "kyverno.imageSecurity.rule.imagePullPolicy" }}
{{- if .Values.imageSecurity.imagePullPolicy.enabled }}
- name: require-approved-image-pull-policy
  match:
    any:
      - resources:
          kinds:
            - Pod
  validate:
    message: Containers must use an approved imagePullPolicy.
    foreach:
      - list: request.object.spec.containers
        pattern:
          imagePullPolicy: {{ .Values.imageSecurity.imagePullPolicy.requiredValue }}
{{- end }}
{{- end }}
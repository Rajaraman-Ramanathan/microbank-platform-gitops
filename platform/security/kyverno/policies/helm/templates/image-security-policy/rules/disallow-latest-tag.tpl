{{- define "kyverno.imageSecurity.rule.disallowLatestTag" }}
{{- if .Values.imageSecurity.disallowLatestTag.enabled }}
- name: disallow-latest-image-tag
  match:
    any:
      - resources:
          kinds:
            - Pod
  validate:
    message: Images must not use the latest tag.
    foreach:
      - list: request.object.spec.containers
        deny:
          conditions:
            any:
              - key: "{{ "{{ element.image }}" }}"
                operator: EndsWith
                value: ":latest"
{{- end }}
{{- end }}
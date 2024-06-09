{{/*
Return the vm.spec.template.spec.tolerations object
*/}}

{{- define "vm.spec.template.spec.tolerations" -}}
{{- if and .template .template.spec .template.spec.tolerations }}
{{- $tolerations := .template.spec.tolerations }}
tolerations:
{{- range $tolerations }}
{{- if and .key .operator }}
- key: {{ .key }}
  operator: {{ .operator }}
{{- end }}
{{- end }}
{{- end }}
{{- end }}
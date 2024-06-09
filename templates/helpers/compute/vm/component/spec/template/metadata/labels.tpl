{{/*
Return the vm.spec.template.metadata.labels object
*/}}

{{- define "vm.spec.template.metadata.labels" -}}
{{- if and .template .template.metadata .template.metadata.labels }}
{{- $labels := .template.metadata.labels }}
labels:
{{- range $labels }}
  {{ .key }}: {{ .value | quote }}
{{- end }}
{{- end }}
{{- end }}
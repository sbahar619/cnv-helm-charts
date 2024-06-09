{{/*
Return the vm.spec.template.metadata.annotations object
*/}}

{{- define "vm.spec.template.metadata.annotations" -}}
{{- if and .template .template.metadata .template.metadata.annotations }}
{{- $annotations := .template.metadata.annotations }}
annotations:
{{- range $annotations }}
  {{ .key }}: {{ .value | quote }}
{{- end }}
{{- end }}
{{- end }}

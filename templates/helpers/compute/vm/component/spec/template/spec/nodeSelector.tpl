{{/*
Return the vm.spec.template.spec.nodeSelector object
*/}}

{{- define "vm.spec.template.spec.nodeSelector" -}}
{{- if .nodeSelector }}
nodeSelector:
{{- if .nodeSelector.key }}
  {{ .nodeSelector.key }}: {{ default "" .nodeSelector.value | quote }}
{{- end }}
{{- end }}
{{- end }}
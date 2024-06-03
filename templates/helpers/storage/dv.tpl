{{/*
Return the dv.spec.pvc.accessModes object
*/}}

{{- define "dv.spec.pvc.accessModes" -}}
{{- range .Values.dv.pvc.accessModes }}
- {{ . }}
{{- end }}
{{- end }}

{{/*
Return the dv.spec.source.registry object
*/}}

{{- define "dv.spec.source.registry" -}}
{{- if .Values.dv.source.registry.enable }}
registry:
  url: {{ .Values.dv.source.registry.url }}
{{- end }}
{{- end }}

{{/*
Return the dv.spec.source.blank object
*/}}

{{- define "dv.spec.source.blank" -}}
{{- if .Values.dv.source.blank.enable }}
blank: {}
{{- end }}
{{- end }}
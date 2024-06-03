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
{{- $registry := .Values.dv.source.registry }}
{{- if $registry.enable }}
registry:
  url: {{ $registry.url }}
  {{- if $registry.secretRef.enable }}
  secretRef: {{ $registry.secretRef.value }}
  {{- end }}
  {{- if $registry.pullMethod.enable }}
  pullMethod: {{ $registry.pullMethod.value }}
  {{- end }}
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
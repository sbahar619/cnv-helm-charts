{{/*
Return the dv.spec.pvc.accessModes object
*/}}

{{- define "dv.spec.pvc.accessModes" -}}
{{- if and .Values.dv .Values.dv.pvc .Values.dv.pvc.accessModes }}
{{- range .Values.dv.pvc.accessModes }}
- {{ . }}
{{- end }}
{{- end }}
{{- end }}

{{/*
Return the dv.spec.source.registry object
*/}}

{{- define "dv.spec.source.registry" -}}
{{- if and .Values.dv .Values.dv.source .Values.dv.source.registry }}
{{- $registry := .Values.dv.source.registry }}
registry:
  {{- if $registry.url }}
  url: {{ $registry.url }}
  {{- end }}
  {{- if $registry.secretRef }}
  secretRef: {{ $registry.secretRef }}
  {{- end }}
  {{- if $registry.pullMethod }}
  pullMethod: {{ $registry.pullMethod }}
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
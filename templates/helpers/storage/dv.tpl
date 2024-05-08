{{/*
Return the dv.spec.pvc.accessModes object
*/}}

{{- define "dv.spec.pvc.accessModes" -}}
{{- range .Values.dv.pvc.accessModes }}
- {{ . }}
{{- end }}
{{- end }}
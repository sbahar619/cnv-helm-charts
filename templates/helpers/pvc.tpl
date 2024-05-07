{{/*
Return the pvc.spec.accessModes object
*/}}

{{- define "pvc.spec.accessModes" -}}
{{- range .Values.pvc.accessModes }}
- {{ . }}
{{- end }}
{{- end }}
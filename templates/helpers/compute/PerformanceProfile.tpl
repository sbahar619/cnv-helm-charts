{{/*
Return the PerformanceProfile.spec.hugepages.pages object
*/}}

{{- define "PerformanceProfile.spec.hugepages.pages" -}}
{{- $pages := .Values.PerformanceProfile.hugepages.pages }}
pages:
{{- range $pages }}
- count: {{ .count }}
  size: {{ .size }}
{{- end }}
{{- end }}
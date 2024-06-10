{{/*
Return the PerformanceProfile.spec.hugepages object
*/}}

{{- define "PerformanceProfile.spec.hugepages" -}}
{{- $hugepages := .Values.PerformanceProfile.hugepages }}
defaultHugepagesSize: {{ $hugepages.defaultHugepagesSize }}
{{- include "PerformanceProfile.spec.hugepages.pages" . }}
{{- end }}

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
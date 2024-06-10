{{/*
Return the PerformanceProfile.spec.cpu object
*/}}

{{- define "PerformanceProfile.spec.cpu" -}}
{{- $cpu := .Values.PerformanceProfile.cpu }}
isolated: {{ $cpu.isolated }}
reserved: {{ $cpu.reserved }}
{{- end }}
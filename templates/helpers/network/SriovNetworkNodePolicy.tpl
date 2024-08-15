{{/*
Return the SriovNetworkNodePolicy.spec.nicSelector object
*/}}

{{- define "SriovNetworkNodePolicy.spec.nicSelector" }}
nicSelector:
  pfNames:
{{- if and .nicSelector .nicSelector.pfNames }}
{{- range .nicSelector.pfNames }}
  - {{ . }}
{{- end }}
{{- end }}
{{- end }}

{{/*
Return the SriovNetworkNodePolicy.spec.deviceType object
*/}}

{{- define "SriovNetworkNodePolicy.spec.deviceType" }}
{{- if .deviceType }}
deviceType: {{ .deviceType }}
{{- end }}
{{- end }}
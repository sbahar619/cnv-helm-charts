{{/*
Return the SriovNetworkNodePolicy.spec.nicSelector object
*/}}

{{- define "SriovNetworkNodePolicy.spec.nicSelector" }}
nicSelector:
  pfNames:
{{- range .nicSelector.pfNames }}
  - {{ . }}
{{- end }}
{{- end }}
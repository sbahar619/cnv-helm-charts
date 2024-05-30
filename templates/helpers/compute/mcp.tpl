{{/*
Return the mcp.metadata.labels object
*/}}

{{- define "mcp.metadata.labels" -}}
{{- $labels := .Values.mcp.labels }}
labels:
{{- range $labels }}
  {{ .key }}: {{ .value }}
{{- end }}
{{- end }}

{{/*
Return the mcp.spec.machineConfigSelector.matchExpressions object
*/}}

{{- define "mcp.spec.machineConfigSelector.matchExpressions" -}}
{{- $matchExpressions := .Values.mcp.machineConfigSelector.matchExpressions }}
{{- if $matchExpressions.enable }}
matchExpressions:
  {{- range $matchExpressions.matchExpressions }}
  - key: {{ .key }}
    operator: {{ .operator }}
    values:
    {{- range .values }}
      - {{ . }}
    {{- end }}
  {{- end }}
{{- end }}
{{- end }}

{{/*
Return the mcp.spec.machineConfigSelector.nodeSelector object
*/}}

{{- define "mcp.spec.nodeSelector.matchLabels" -}}
{{- $matchLabels := .Values.mcp.nodeSelector.matchLabels }}
{{- if $matchLabels.enable }}
matchLabels:
  {{ $matchLabels.key }}: {{  default "" $matchLabels.Value | quote }}
{{- end }}
{{- end }}
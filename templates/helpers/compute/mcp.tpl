{{/*
Return the mcp.metadata.labels object
*/}}

{{- define "mcp.metadata.labels" -}}
{{- if and .Values.mcp .Values.mcp.labels }}
{{- $labels := .Values.mcp.labels }}
labels:
{{- range $labels }}
  {{ .key }}: {{ .value }}
{{- end }}
{{- end }}
{{- end }}

{{/*
Return the mcp.spec.machineConfigSelector.matchExpressions object
*/}}

{{- define "mcp.spec.machineConfigSelector.matchExpressions" -}}
{{- if and .Values.mcp .Values.mcp.machineConfigSelector .Values.mcp.machineConfigSelector.matchExpressions }}
{{- $matchExpressions := .Values.mcp.machineConfigSelector.matchExpressions }}
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
{{- if and .Values.mcp .Values.mcp.nodeSelector .Values.mcp.nodeSelector.matchLabels }}
{{- $matchLabels := .Values.mcp.nodeSelector.matchLabels }}
matchLabels:
  {{ $matchLabels.key }}: {{  default "" $matchLabels.Value | quote }}
{{- end }}
{{- end }}
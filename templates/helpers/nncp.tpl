{{/*
Return the nncp.spec.interfaces object
*/}}

{{- define "nncp.spec.interfaces" -}}
{{- range .Values.nncp.interfaces }}
  - name: {{ .name }} 
    type: {{ .type }}
    state: {{ .state }} 
    ipv4:
      enabled: false 
    bridge:
      options:
        stp:
          enabled: false 
      port:
      {{- range .ports }}
        - name: {{ . }} 
      {{- end }}
{{- end }}
{{- end }}

{{/*
Return the nncp.spec.nodeSelector object
*/}}

{{- define "nncp.spec.nodeSelector" -}}
{{- if .Values.nncp.nodeSelector.enable }}
nodeSelector:
  {{ .Values.nncp.nodeSelector.key }}: {{ .Values.nncp.nodeSelector.value }}
{{- end }}
{{- end }}
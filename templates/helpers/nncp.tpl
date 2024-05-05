{{/*
Return the nncp.spec.interfaces object
*/}}

{{- define "nncp.spec.interfaces" -}}
{{- range .Values.nncp.interfaces }}
  - name: {{ .name }} 
    description: {{ .description }} 
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
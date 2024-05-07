{{/*
Return the nncp.spec.interfaces object
*/}}

{{- define "nncp.spec.interfaces" -}}
{{- range .interfaces }}
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
{{- if .nodeSelector.enable }}
nodeSelector:
  {{ .nodeSelector.key }}: {{ .nodeSelector.value | quote}}
{{- end }}
{{- end }}
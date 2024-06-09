{{/*
Return the nncp.spec.interfaces object
*/}}

{{- define "nncp.spec.interfaces" -}}
{{- if .interfaces }}
{{- range .interfaces }}
  {{- if .name }}
  - name: {{ .name }} 
  {{- end }}
    {{- if .type }}
    type: {{ .type }}
    {{- end }}
    {{- if .state }}
    state: {{ .state }} 
    {{- end }}
    ipv4:
      enabled: false 
    bridge:
      options:
        stp:
          enabled: false 
      port:
      {{- if .ports }}
      {{- range .ports }}
        - name: {{ . }} 
      {{- end }}
      {{- end }}
{{- end }}
{{- end }}
{{- end }}

{{/*
Return the nncp.spec.nodeSelector object
*/}}

{{- define "nncp.spec.nodeSelector" -}}
{{- if .nodeSelector  }}
nodeSelector:
  {{ .nodeSelector.key }}: {{  default "" .nodeSelector.value | quote }}
{{- end }}
{{- end }}
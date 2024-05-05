{{/*
Return the vm.spec.template.spec.domain.devices object
*/}}

{{- define "vm.spec.template.spec.domain.devices" -}}
{{- if .Values.vm.domain.devices.interface.enable }}
{{- range .Values.vm.domain.devices.interface.interfaces }}
- {{ .type }}: {}
  name: {{ .name }}
{{- end }}
{{- end }}
{{- end }}

{{/*
Return the vm.spec.template.spec.networks object
*/}}

{{- define "vm.spec.template.spec.networks" -}}
{{- if .Values.vm.network.enable }}
{{- range .Values.vm.network.networks }}
- name: {{ .name }}
  {{- if ( eq .type "multus") }}
  {{ .type }}:
    networkName: {{ .networkName }}
  {{- else }}
  {{ .type }}: {}
  {{- end }}
{{- end }}
{{- end }}
{{- end }}
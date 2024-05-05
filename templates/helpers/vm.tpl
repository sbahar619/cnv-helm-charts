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

{{/*
Return the vm.spec.template.spec.volumes.cloudInitNoCloud object
*/}}

{{- define "vm.spec.template.spec.volumes.cloudInitNoCloud" -}}
{{- if .Values.vm.cloudInitNoCloud.enable }}
- cloudInitNoCloud:

  {{- if .Values.vm.cloudInitNoCloud.networkData.enable }}
    networkData: |
      version: {{ .Values.vm.cloudInitNoCloud.networkData.version }}

      {{- if .Values.vm.cloudInitNoCloud.networkData.ethernet.enable }}
      ethernets:
      {{- range .Values.vm.cloudInitNoCloud.networkData.ethernet.ethernets }}
        {{ .name }}:
        {{- if .address.enable }}
          addresses:
          {{- range .address.addresses }}
          - {{ . }}
          {{- end }}
        {{- end }}
        {{- if .dhcp4.enable }}
          dhcp4: {{ .dhcp4.value }}
        {{- end }}
        {{- if .gateway6.enable }}
          gateway6: {{ .gateway6.value }}
        {{- end }}
      {{- end }}
      {{- end }}

  {{- end }}
{{- end }}
{{- end }}
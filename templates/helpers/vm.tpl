{{/*
Return the vm.spec.template.spec.domain.devices object
*/}}

{{- define "vm.spec.template.spec.domain.devices" -}}
{{- if .domain.devices.interface.enable }}
{{- range .domain.devices.interface.interfaces }}
- {{ .type }}: {}
  name: {{ .name }}
{{- end }}
{{- end }}
{{- end }}

{{/*
Return the vm.spec.template.spec.networks object
*/}}

{{- define "vm.spec.template.spec.networks" -}}
{{- if .network.enable }}
{{- range .network.networks }}
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
{{- if .cloudInitNoCloud.enable }}
- cloudInitNoCloud:

  {{- if .cloudInitNoCloud.networkData.enable }}
    networkData: |
      version: {{ .cloudInitNoCloud.networkData.version }}

      {{- if .cloudInitNoCloud.networkData.ethernet.enable }}
      ethernets:
      {{- range .cloudInitNoCloud.networkData.ethernet.ethernets }}
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
  {{- if .cloudInitNoCloud.userData.enable }}
    userData: |-
      #cloud-config
      user: {{ .cloudInitNoCloud.userData.user }}
      password: {{ .cloudInitNoCloud.userData.password }}
      chpasswd: { expire: False }
  {{- end }}

{{- end }}
{{- end }}

{{/*
Return the vm.spec.template.spec.nodeSelector object
*/}}

{{- define "vm.spec.template.spec.nodeSelector" -}}
{{- if .nodeSelector.enable }}
nodeSelector:
  {{ .nodeSelector.key }}: {{ .nodeSelector.value }}
{{- end }}
{{- end }}
{{/*
Return the vm.spec.template.spec.domain.devices object
*/}}

{{- define "vm.spec.template.spec.domain.devices" -}}
{{- $interface := .domain.devices.interface }}
{{- if $interface.enable }}
{{- range $interface.interfaces }}
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

  {{- $networkData := .cloudInitNoCloud.networkData }}
  {{- if $networkData.enable }}
    networkData: |
      version: {{ $networkData.version }}
      {{- $ethernet := $networkData.ethernet }}
      {{- if $ethernet.enable }}
      ethernets:
      {{- range $ethernet.ethernets }}
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
  {{- $userData := .cloudInitNoCloud.userData }}
    userData: |-
      #cloud-config
      user: {{ $userData.user }}
      password: {{ $userData.password }}
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

{{/*
Return the vm.spec.template.spec.domain.devices.networkInterfaceMultiqueue object
*/}}

{{- define "vm.spec.template.spec.domain.devices.networkInterfaceMultiqueue" -}}
{{- $networkInterfaceMultiqueue := .domain.devices.networkInterfaceMultiqueue }}
{{- if $networkInterfaceMultiqueue.enable }}
networkInterfaceMultiqueue: {{ $networkInterfaceMultiqueue.value }}
{{- end }}
{{- end }}

{{/*
Return the vm.spec.template.spec.domain.cpu object
*/}}

{{- define "vm.spec.template.spec.domain.cpu" -}}
{{- $cpu := .domain.cpu }}
{{- if $cpu.enable }}
cpu:
{{- $cores := $cpu.cores }}
{{- if $cores.enable }}
  cores: {{ $cores.value }}
{{- end }}
{{- $dedicatedCpuPlacement := $cpu.dedicatedCpuPlacement }}
{{- if $dedicatedCpuPlacement.enable }}
  dedicatedCpuPlacement: {{ $dedicatedCpuPlacement.value }}
{{- end }}
{{- end }}
{{- end }}
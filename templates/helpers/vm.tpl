{{/*
Return the vm.spec.template.spec.domain.devices object
*/}}

{{- define "vm.spec.template.spec.domain.devices" -}}
{{- $interfaceContext := .domain.devices.interface }}
{{- if $interfaceContext.enable }}
{{- range $interfaceContext.interfaces }}
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

  {{- $networkDataContext := .cloudInitNoCloud.networkData }}
  {{- if $networkDataContext.enable }}
    networkData: |
      version: {{ $networkDataContext.version }}
      {{- $ethernetContext := $networkDataContext.ethernet }}
      {{- if $ethernetContext.enable }}
      ethernets:
      {{- range $ethernetContext.ethernets }}
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
  {{- $userDataContext := .cloudInitNoCloud.userData }}
    userData: |-
      #cloud-config
      user: {{ $userDataContext.user }}
      password: {{ $userDataContext.password }}
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
{{- $networkInterfaceMultiqueueContext := .domain.devices.networkInterfaceMultiqueue }}
{{- if $networkInterfaceMultiqueueContext.enable }}
networkInterfaceMultiqueue: {{ $networkInterfaceMultiqueueContext.value }}
{{- end }}
{{- end }}
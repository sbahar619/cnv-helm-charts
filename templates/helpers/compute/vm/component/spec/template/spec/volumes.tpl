{{/*
Return the vm.spec.template.spec.volumes.cloudInitNoCloud object
*/}}

{{- define "vm.spec.template.spec.volumes.cloudInitNoCloud" -}}
{{- if .cloudInitNoCloud }}

  {{- if .cloudInitNoCloud.networkData }}
  {{- $networkData := .cloudInitNoCloud.networkData }}
    networkData: |
      version: {{ $networkData.version }}
      {{- if $networkData.ethernets }}
      {{- $ethernets := $networkData.ethernets }}
      ethernets:
      {{- range $ethernets }}
        {{ .name }}:
        {{- if .addresses }}
          addresses:
          {{- range .addresses }}
          - {{ . }}
          {{- end }}
        {{- end }}
        {{- if and .dhcp4 .dhcp4.value }}
          dhcp4: {{ .dhcp4.value }}
        {{- end }}
        {{- if and .gateway6 .gateway6.value }}
          gateway6: {{ .gateway6.value }}
        {{- end }}
      {{- end }}
      {{- end }}
  {{- end }}

  {{- if .cloudInitNoCloud.userData }}
  {{- $userData := .cloudInitNoCloud.userData }}
    userData: |-
      #cloud-config
      {{- if $userData.user }}
      user: {{ $userData.user }}
      {{- end }}
      {{- if $userData.password }}
      password: {{ $userData.password }}
      {{- end }}
      chpasswd: { expire: False }
  {{- end }}

{{- end }}
{{- end }}

{{/*
Return the vm.spec.template.spec.volumess object
*/}}

{{- define "vm.spec.template.spec.volumes" -}}
{{- $volumes := .volumes }}
volumes:
{{- range $volumes }}
{{- if eq .type "containerDisk" }}
- {{ .type }}:
    image: {{ .image }}
  name: {{ .name }}
{{- else if eq .type "cloudInitNoCloud" }}
- {{ .type }}:
  {{- include "vm.spec.template.spec.volumes.cloudInitNoCloud" . }}
  name: {{ .name }}
{{- else if eq .type "dataVolume" }}
- {{ .type }}:
    name: {{ .dataVolume.name }}
  name: {{ .name }}
{{- end }}
{{- end }}
{{- end }}
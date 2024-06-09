{{/*
Return the vm.spec.template.spec.networks object
*/}}

{{- define "vm.spec.template.spec.networks" -}}
{{- if .networks }}
networks:
{{- range .networks }}
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
Return the vm.spec.template.spec.nodeSelector object
*/}}

{{- define "vm.spec.template.spec.nodeSelector" -}}
{{- if .nodeSelector }}
nodeSelector:
{{- if .nodeSelector.key }}
  {{ .nodeSelector.key }}: {{ default "" .nodeSelector.value | quote }}
{{- end }}
{{- end }}
{{- end }}

{{/*
Return the vm.spec.template.spec.tolerations object
*/}}

{{- define "vm.spec.template.spec.tolerations" -}}
{{- if and .template .template.spec .template.spec.tolerations }}
{{- $tolerations := .template.spec.tolerations }}
tolerations:
{{- range $tolerations }}
{{- if and .key .operator }}
- key: {{ .key }}
  operator: {{ .operator }}
{{- end }}
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

{{/*
Return the vm.spec.template.spec.terminationGracePeriodSeconds object
*/}}

{{- define "vm.spec.template.spec.terminationGracePeriodSeconds" -}}
{{- if and .template .template.spec }}
{{- $terminationGracePeriodSeconds := .template.spec.terminationGracePeriodSeconds }}
terminationGracePeriodSeconds: {{ $terminationGracePeriodSeconds }}
{{- end }}
{{- end }}

{{/*
Return the vm.spec.template.metadata.labels object
*/}}

{{- define "vm.spec.template.metadata.labels" -}}
{{- if and .template .template.metadata .template.metadata.labels }}
{{- $labels := .template.metadata.labels }}
labels:
{{- range $labels }}
  {{ .key }}: {{ .value | quote }}
{{- end }}
{{- end }}
{{- end }}

{{/*
Return the vm.spec.template.metadata.annotations object
*/}}

{{- define "vm.spec.template.metadata.annotations" -}}
{{- if and .template .template.metadata .template.metadata.annotations }}
{{- $annotations := .template.metadata.annotations }}
annotations:
{{- range $annotations }}
  {{ .key }}: {{ .value | quote }}
{{- end }}
{{- end }}
{{- end }}

{{/*
Return the vm.spec.template.spec.domain object
*/}}

{{- define "vm.spec.template.spec.domain" -}}
{{- if .template.spec.domain }}
domain:
  {{- include "vm.spec.template.spec.domain.ioThreadsPolicy" . | indent 2 }}
  {{- include "vm.spec.template.spec.domain.cpu" . | indent 2 }}
  {{- include "vm.spec.template.spec.domain.memory" . | indent 2 }}
  {{- include "vm.spec.template.spec.domain.devices" . | indent 2 }}
  {{- include "vm.spec.template.spec.domain.resources.requests.memory" . | indent 2 }}
{{- end }}
{{- end }}

{{/*
Return the vm.spec.template.spec object
*/}}

{{- define "vm.spec.template.spec" -}}
  {{- include "vm.spec.template.spec.nodeSelector" . | indent 6 }}
  {{- include "vm.spec.template.spec.tolerations" . | indent 6 }}
  {{- include "vm.spec.template.spec.domain" . | indent 6 }}
  {{- include "vm.spec.template.spec.volumes" . | indent 6 }}
  {{- include "vm.spec.template.spec.terminationGracePeriodSeconds" . | indent 6 }}
  {{- include "vm.spec.template.spec.networks" . | indent 6 }}
{{- end }}

{{/*
Return the vm.spec.template.metadata object
*/}}

{{- define "vm.spec.template.metadata" -}}
    {{- include "vm.spec.template.metadata.labels" . | indent 6 }}
    {{- include "vm.spec.template.metadata.annotations" . | indent 6 }}
{{- end }}

{{/*
Return the vm.spec.template object
*/}}

{{- define "vm.spec.template" -}}
  {{- if .template }}
  template:
    {{- if .template.metadata }}
    metadata:
      {{- include "vm.spec.template.metadata" . }}
    {{- end }}
    {{- if .template.spec }}
    spec:
      {{- include "vm.spec.template.spec" . }}
    {{- end }}
  {{- end }}
{{- end }}

{{/*
Return the vm.spec object
*/}}

{{- define "vm.spec" -}}
running: {{ .running }}
{{- include "vm.spec.template" . }}
{{- end }}

{{/*
Return the vm.spec.template.spec.domain.devices object
*/}}

{{- define "vm.spec.template.spec.domain.devices" -}}
{{- $domain := .template.spec.domain }}
{{- if $domain.devices }}
{{- $devices := $domain.devices }}
devices:
{{- if $devices.interfaces }}
  {{- $interfaces := $devices.interfaces }}
  interfaces:
  {{- range $interfaces }}
    - {{ .type }}: {}
      name: {{ .name }}
  {{- end }}
{{- end }}
{{- if $devices.networkInterfaceMultiqueue }}
  {{- $networkInterfaceMultiqueue := $devices.networkInterfaceMultiqueue }}
  networkInterfaceMultiqueue: {{ $networkInterfaceMultiqueue.value }}
{{- end }}
{{- if $devices.autoattachGraphicsDevice }}
  {{- $autoattachGraphicsDevice := $devices.autoattachGraphicsDevice }}
  autoattachGraphicsDevice: {{ $autoattachGraphicsDevice.value }}
{{- end }}
{{- if $devices.autoattachMemBalloon }}
  {{- $autoattachMemBalloon := $devices.autoattachMemBalloon }}
  autoattachMemBalloon: {{ $autoattachMemBalloon.value }}
{{- end }}
{{- if $devices.autoattachSerialConsole }}
  {{- $autoattachSerialConsole := $devices.autoattachSerialConsole }}
  autoattachSerialConsole: {{ $autoattachSerialConsole.value }}
{{- end }}
{{- if $devices.disks }}
  {{- $disks := $devices.disks }}
  disks:
  {{- range $disks }}
  - name: {{ .name }}
    disk:
      bus: {{ .bus }}
  {{- end }}
{{- end }}
{{- end }}
{{- end }}

{{/*
Return the vm.spec.template.spec.domain.ioThreadsPolicy object
*/}}

{{- define "vm.spec.template.spec.domain.ioThreadsPolicy" -}}
{{- $domain := .template.spec.domain }}
{{- if $domain.ioThreadsPolicy }}
{{- $ioThreadsPolicy := $domain.ioThreadsPolicy }}
ioThreadsPolicy: {{ $ioThreadsPolicy.value }}
{{- end }}
{{- end }}

{{/*
Return the vm.spec.template.spec.domain.cpu object
*/}}

{{- define "vm.spec.template.spec.domain.cpu" -}}
{{- $domain := .template.spec.domain }}
{{- if $domain.cpu }}
{{- $cpu := $domain.cpu }}
cpu:
{{- if $cpu.cores }}
{{- $cores := $cpu.cores }}
  cores: {{ $cores.value }}
{{- end }}
{{- if $cpu.sockets }}
{{- $sockets := $cpu.sockets }}
  sockets: {{ $sockets.value }}
{{- end }}
{{- if $cpu.threads }}
{{- $threads := $cpu.threads }}
  threads: {{ $threads.value }}
{{- end }}
{{- if $cpu.dedicatedCpuPlacement }}
{{- $dedicatedCpuPlacement := $cpu.dedicatedCpuPlacement }}
  dedicatedCpuPlacement: {{ $dedicatedCpuPlacement.value }}
{{- end }}
{{- if $cpu.isolateEmulatorThread }}
{{- $isolateEmulatorThread := $cpu.isolateEmulatorThread }}
  isolateEmulatorThread: {{ $isolateEmulatorThread.value }}
{{- end }}
{{- if $cpu.model }}
{{- $model := $cpu.model }}
  model: {{ $model.value }}
{{- end }}
{{- if $cpu.numa }}
{{- $numa := $cpu.numa }}
  numa:
    {{ $numa.key }}: {}
{{- end }}
{{- if $cpu.realtime }}
{{- $realtime := $cpu.realtime }}
  realtime: {}
{{- end }}
{{- end }}
{{- end }}

{{/*
Return the vm.spec.template.spec.domain.memory object
*/}}

{{- define "vm.spec.template.spec.domain.memory" -}}
{{- $domain := .template.spec.domain }}
{{- if $domain.memory }}
{{- $memory := $domain.memory }}
memory:
  {{- if $memory.guest }}
  guest: {{ $memory.guest }}
  {{- end }}
  {{- if $memory.hugepages }}
  {{- $hugepages := $memory.hugepages }}
  hugepages:
    {{- if $hugepages.pageSize }}
    pageSize: {{ $hugepages.pageSize }}
    {{- end }}
  {{- end }}
{{- end }}
{{- end }}

{{/*
Return the vm.spec.template.spec.domain.resources object
*/}}

{{- define "vm.spec.template.spec.domain.resources.requests.memory" -}}
{{- $domain := .template.spec.domain }}
{{- if and $domain.resources $domain.resources.requests $domain.resources.requests.memory }}
{{- $memory := $domain.resources.requests.memory }}
resources:
  requests:
    memory: {{ $memory }}
{{- end }}
{{- end }}

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
Return the vm.spec.template.spec.terminationGracePeriodSeconds object
*/}}

{{- define "vm.spec.template.spec.terminationGracePeriodSeconds" -}}
{{- if .template.spec.terminationGracePeriodSeconds }}
{{- $terminationGracePeriodSeconds := .template.spec.terminationGracePeriodSeconds }}
terminationGracePeriodSeconds: {{ $terminationGracePeriodSeconds }}
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







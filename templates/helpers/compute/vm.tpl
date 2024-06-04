{{/*
Return the vm.spec.template.spec.domain.devices object
*/}}

{{- define "vm.spec.template.spec.domain.devices" -}}
{{- $devices := .domain.devices }}
{{- $interface := $devices.interface }}
{{- if $interface.enable }}
interfaces:
{{- range $interface.interfaces }}
  - {{ .type }}: {}
    name: {{ .name }}
{{- end }}
{{- end }}
{{- $networkInterfaceMultiqueue := $devices.networkInterfaceMultiqueue }}
{{- if $networkInterfaceMultiqueue.enable }}
networkInterfaceMultiqueue: {{ $networkInterfaceMultiqueue.value }}
{{- end }}
{{- $autoattachGraphicsDevice := $devices.autoattachGraphicsDevice }}
{{- if $autoattachGraphicsDevice.enable }}
autoattachGraphicsDevice: {{ $autoattachGraphicsDevice.value }}
{{- end }}
{{- $autoattachMemBalloon := $devices.autoattachMemBalloon }}
{{- if $autoattachMemBalloon.enable }}
autoattachMemBalloon: {{ $autoattachMemBalloon.value }}
{{- end }}

{{- $autoattachSerialConsole := $devices.autoattachSerialConsole }}
{{- if $autoattachSerialConsole.enable }}
autoattachSerialConsole: {{ $autoattachSerialConsole.value }}
{{- end }}

{{- $disks := $devices.disks }}
disks:
{{- range $disks }}
- name: {{ .name }}
  disk:
    bus: {{ .bus }}
{{- end }}
{{- end }}

{{/*
Return the vm.spec.template.spec.domain.ioThreadsPolicy object
*/}}

{{- define "vm.spec.template.spec.domain.ioThreadsPolicy" -}}
{{- $ioThreadsPolicy := .domain.ioThreadsPolicy }}
{{- if $ioThreadsPolicy.enable }}
ioThreadsPolicy: {{ $ioThreadsPolicy.value }}
{{- end }}
{{- end }}

{{/*
Return the vm.spec.template.spec.domain.terminationGracePeriodSeconds object
*/}}

{{- define "vm.spec.template.spec.domain.terminationGracePeriodSeconds" -}}
{{- $terminationGracePeriodSeconds := .domain.terminationGracePeriodSeconds }}
{{- if $terminationGracePeriodSeconds.enable }}
terminationGracePeriodSeconds: {{ $terminationGracePeriodSeconds.value }}
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
  {{ .nodeSelector.key }}: {{ default "" .nodeSelector.value | quote }}
{{- end }}
{{- end }}



{{/*
Return the vm.spec.template.spec.tolerations object
*/}}

{{- define "vm.spec.template.spec.tolerations" -}}
{{- if and .template .template.spec .template.spec.tolerations }}
{{- $tolerations := .template.spec.tolerations }}
{{- if $tolerations.enable }}
tolerations:
{{- range $tolerations.tolerations }}
- key: {{ .key }}
  operator: {{ .operator}}
{{- end }}
{{- end }}
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
{{- $sockets := $cpu.sockets }}
{{- if $sockets.enable }}
  sockets: {{ $sockets.value }}
{{- end }}
{{- $threads := $cpu.threads }}
{{- if $threads.enable }}
  threads: {{ $threads.value }}
{{- end }}
{{- $dedicatedCpuPlacement := $cpu.dedicatedCpuPlacement }}
{{- if $dedicatedCpuPlacement.enable }}
  dedicatedCpuPlacement: {{ $dedicatedCpuPlacement.value }}
{{- end }}
{{- $isolateEmulatorThread := $cpu.isolateEmulatorThread }}
{{- if $isolateEmulatorThread.enable }}
  isolateEmulatorThread: {{ $isolateEmulatorThread.value }}
{{- end }}
{{- $model := $cpu.model }}
{{- if $model.enable }}
  model: {{ $model.value }}
{{- end }}
{{- $numa := $cpu.numa }}
{{- if $numa.enable }}
  numa:
    {{ $numa.key }}: {}
{{- end }}
{{- $realtime := $cpu.realtime }}
{{- if $realtime.enable }}
  realtime: {}
{{- end }}
{{- end }}
{{- end }}

{{/*
Return the vm.spec.template.spec.domain.memory object
*/}}

{{- define "vm.spec.template.spec.domain.memory" -}}
{{- $memory := .domain.memory }}
{{- if $memory.enable }}
memory:
  guest: {{ $memory.guest }}
  {{- $hugepages := $memory.hugepages }}
  {{- if $hugepages }}
  hugepages:
    pageSize: {{ $hugepages.pageSize }}
  {{- end }}
{{- end }}
{{- end }}

{{/*
Return the vm.spec.template.spec.domain.resources object
*/}}

{{- define "vm.spec.template.spec.domain.resources.requests.memory" -}}
{{- $memory := .domain.resources.requests.memory }}
resources:
  requests:
    memory: {{  $memory }}
{{- end }}

{{/*
Return the vm.spec.template.metadata.annotations object
*/}}

{{- define "vm.spec.template.metadata.annotations" -}}
{{- if and .template  .template.metadata .template.metadata.annotations }}
{{- $annotations := .template.metadata.annotations }}
{{- if $annotations.enable }}
annotations:
{{- range $annotations.annotations }}
  {{ .key }}: {{ .value }}
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
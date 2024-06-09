{{/*
Return the vm.spec.template.spec.domain.devices object
*/}}

{{- define "vm.spec.template.spec.domain.devices" -}}
{{- if .template.spec.domain.devices }}
{{- $devices := .template.spec.domain.devices }}
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
{{- if .template.spec.domain.ioThreadsPolicy }}
{{- $ioThreadsPolicy := .template.spec.domain.ioThreadsPolicy }}
ioThreadsPolicy: {{ $ioThreadsPolicy.value }}
{{- end }}
{{- end }}

{{/*
Return the vm.spec.template.spec.domain.cpu object
*/}}

{{- define "vm.spec.template.spec.domain.cpu" -}}
{{- if .template.spec.domain.cpu }}
{{- $cpu := .template.spec.domain.cpu }}
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
{{- if .template.spec.domain.memory }}
{{- $memory := .template.spec.domain.memory }}
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
{{- if and .template .template.spec .template.spec.domain .template.spec.domain.resources .template.spec.domain.resources.requests .template.spec.domain.resources.requests.memory }}
{{- $memory := .template.spec.domain.resources.requests.memory }}
resources:
  requests:
    memory: {{ $memory }}
{{- end }}
{{- end }}
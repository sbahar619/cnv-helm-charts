{{/*
Return the vm.spec.template.spec.domain.devices object
*/}}

{{- define "vm.spec.template.spec.domain.devices" -}}

{{- $domain := .template.spec.domain }}
{{- if $domain.devices }}
{{- $devices := $domain.devices }}
devices:

  {{- if .template.spec.domain.devices.interfaces }}
  interfaces:
    {{- include "vm.spec.template.spec.domain.devices.interfaces" . }}
  {{- end }}

  {{- $keyValuePairs := dict 
    "networkInterfaceMultiqueue" $devices.networkInterfaceMultiqueue 
    "autoattachGraphicsDevice" $devices.autoattachGraphicsDevice 
    "autoattachMemBalloon" $devices.autoattachMemBalloon 
    "autoattachSerialConsole" $devices.autoattachSerialConsole 
  -}}

  {{- range $key, $value := $keyValuePairs }}
    {{- include "renderKeyValuePair" (dict "key" $key "value" $value) }}
  {{- end }}

  {{- if $devices.disks }}
  {{- $disks := $devices.disks }}
  disks:
    {{- include "vm.spec.template.spec.domain.devices.disks" . }}
  {{- end }}

{{- end }}
{{- end }}

{{/*
Return the vm.spec.template.spec.domain.devices.interfaces object
*/}}

{{- define "vm.spec.template.spec.domain.devices.interfaces" -}}

  {{- $interfaces := .template.spec.domain.devices.interfaces }}
  {{- range $interfaces }}
    - {{ .type }}: {}
      name: {{ .name }}
  {{- end }}

{{- end }}

{{/*
Return the vm.spec.template.spec.domain.devices.disks object
*/}}

{{- define "vm.spec.template.spec.domain.devices.disks" -}}

  {{- $disks := .template.spec.domain.devices.disks }}
  {{- range $disks }}
    - name: {{ .name }}
      disk:
        bus: {{ .bus }}
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

  {{- $keyValuePairs := dict 
    "cores" $cpu.cores 
    "sockets" $cpu.sockets
    "threads" $cpu.threads
    "dedicatedCpuPlacement" $cpu.dedicatedCpuPlacement
    "isolateEmulatorThread" $cpu.isolateEmulatorThread
    "model" $cpu.model
    "realtime" "{}"
  -}}

  {{- range $key, $value := $keyValuePairs }}
    {{- include "renderKeyValuePair" (dict "key" $key "value" $value) }}
  {{- end }}

{{- if $cpu.numa }}
{{- $numa := $cpu.numa }}
  numa:
    {{- include "renderKeyValuePair" (dict "key" $numa.key "value" "{}") | indent 2 }}
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

  {{- include "renderKeyValuePair" (dict "key" "guest" "value" $memory.guest) }}

  {{- if $memory.hugepages }}
  {{- $hugepages := $memory.hugepages }}
  hugepages:
    {{- include "renderKeyValuePair" (dict "key" "pageSize" "value" $hugepages.pageSize) | indent 2 }}
  {{- end }}

{{- end }}
{{- end }}

{{/*
Return the vm.spec.template.spec.domain.resources object
*/}}

{{- define "vm.spec.template.spec.domain.resources.requests.memory" -}}

{{- $domain := .template.spec.domain }}
{{- if $domain.resources }}
resources:
  {{- if $domain.resources.requests }}
  requests:
    {{- include "renderKeyValuePair" (dict "key" "memory" "value" $domain.resources.requests.memory) | indent 2 }}
  {{- end }}
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

  {{- $terminationGracePeriodSeconds := .template.spec.terminationGracePeriodSeconds }}
  {{- include "renderKeyValuePair" (dict "key" "terminationGracePeriodSeconds" "value" $terminationGracePeriodSeconds) }}
{{- end }}


{{/*
Return the vm.spec.template.spec.domain.ioThreadsPolicy object
*/}}

{{- define "vm.spec.template.spec.domain.ioThreadsPolicy" -}}

  {{- $ioThreadsPolicy := .template.spec.domain.ioThreadsPolicy }}
  {{- include "renderKeyValuePair" (dict "key" "ioThreadsPolicy" "value" $ioThreadsPolicy) }}
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
    networkData: {{ printf "|" }}
      {{- include "renderKeyValuePair" (dict "key" "version" "value" $networkData.version) | indent 4 }}

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

          {{- include "renderKeyValuePair" (dict "key" "dhcp4" "value" .dhcp4) | indent 8 }}
          {{- include "renderKeyValuePair" (dict "key" "gateway6" "value" .gateway6) | indent 8 }}
      {{- end }}
      {{- end }}
  {{- end }}

  {{- if .cloudInitNoCloud.userData }}
  {{- $userData := .cloudInitNoCloud.userData }}
    userData: {{ printf "|-" }}
      {{- include "renderKeyValuePair" (dict "key" "user" "value" $userData.user) | indent 4 }}
      {{- include "renderKeyValuePair" (dict "key" "password" "value" $userData.password) | indent 4 }}
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

{{/*
Return the vm.spec.dataVolumeTemplates object
*/}}

{{- define "vm.spec.dataVolumeTemplates" -}}

{{- if .dataVolumeTemplates }}
  dataVolumeTemplates:
  {{- range .dataVolumeTemplates }}
    - apiVersion: cdi.kubevirt.io/v1beta1
      kind: DataVolume
      metadata:
        {{- include "renderKeyValuePair" (dict "key" "name" "value" .metadata.name) | indent 6 }}
      spec:
        sourceRef:
        {{- $sourceRef := .spec.sourceRef }}

          {{- include "renderKeyValuePair" (dict "key" "kind" "value" $sourceRef.kind) | indent 8 }}
          {{- include "renderKeyValuePair" (dict "key" "name" "value" $sourceRef.name) | indent 8 }}
          {{- include "renderKeyValuePair" (dict "key" "namespace" "value" $sourceRef.namespace) | indent 8 }}
        storage:
        {{- $storage := .spec.storage }}
          resources:
            requests:
              {{- include "renderKeyValuePair" (dict "key" "storage" "value" $storage.resources.requests.storage) | indent 12 }}
  {{- end }}
{{- end }}
{{- end }}
{{/*
Return the vm.spec.template.spec.domain.devices object
*/}}

{{- define "vm.spec.template.spec.domain.devices" -}}

{{- $domain := .Values.vm.template.spec.domain }}
{{- if $domain.devices }}
{{- $devices := $domain.devices }}
devices:

  {{- if .Values.vm.template.spec.domain.devices.interfaces }}
  {{- $interfaces := $devices.interfaces }}
  interfaces:
    {{- toYaml $interfaces | nindent 4 }}
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
    {{- toYaml $disks | nindent 4 }}
  {{- end }}

{{- end }}
{{- end }}

{{/*
Return the vm.spec.template.spec.domain.cpu object
*/}}

{{- define "vm.spec.template.spec.domain.cpu" -}}

{{- $domain := .Values.vm.template.spec.domain }}
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

{{- $domain := .Values.vm.template.spec.domain }}
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

{{- $domain := .Values.vm.template.spec.domain }}
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

{{- if .Values.vm.networks }}
networks:
{{- range .Values.vm.networks }}
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

{{- if .Values.vm.nodeSelector }}
{{- $nodeSelector := .Values.vm.nodeSelector }}
nodeSelector:
{{- if .Values.vm.nodeSelector.key }}
  {{ $nodeSelector.key }}: {{ default "" $nodeSelector.value | quote }}
{{- end }}

{{- end }}
{{- end }}

{{/*
Return the vm.spec.template.spec.terminationGracePeriodSeconds object
*/}}

{{- define "vm.spec.template.spec.terminationGracePeriodSeconds" -}}

  {{- $terminationGracePeriodSeconds := .Values.vm.template.spec.terminationGracePeriodSeconds }}
  {{- include "renderKeyValuePair" (dict "key" "terminationGracePeriodSeconds" "value" $terminationGracePeriodSeconds) }}
{{- end }}


{{/*
Return the vm.spec.template.spec.domain.ioThreadsPolicy object
*/}}

{{- define "vm.spec.template.spec.domain.ioThreadsPolicy" -}}

  {{- $ioThreadsPolicy := .Values.vm.template.spec.domain.ioThreadsPolicy }}
  {{- include "renderKeyValuePair" (dict "key" "ioThreadsPolicy" "value" $ioThreadsPolicy) }}
{{- end }}

{{/*
Return the vm.spec.template.spec.tolerations object
*/}}

{{- define "vm.spec.template.spec.tolerations" -}}

{{- if and .Values.vm.template .Values.vm.template.spec .Values.vm.template.spec.tolerations }}
{{- $tolerations := .Values.vm.template.spec.tolerations }}
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
    networkData: {{ printf "|" }} {{ toYaml .cloudInitNoCloud.networkData | nindent 6 }}
  {{- end }}

  {{- if .cloudInitNoCloud.userData }}
  {{- $userData := .cloudInitNoCloud.userData }}
    userData: {{ printf "|-" }}
      #cloud-config
      {{- toYaml .cloudInitNoCloud.userData | nindent 6 }}
      chpasswd: { expire: False }
  {{- end }}

{{- end }}
{{- end }}

{{/*
Return the vm.spec.template.spec.volumess object
*/}}

{{- define "vm.spec.template.spec.volumes" -}}

{{- $volumes := .Values.vm.template.spec.volumes }}
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

{{- if and .Values.vm.template .Values.vm.template.metadata .Values.vm.template.metadata.labels }}
{{- $labels := .Values.vm.template.metadata.labels }}
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
{{- if .Values.vm.template.metadata.annotations }}
{{- $annotations := .Values.vm.template.metadata.annotations }}
annotations: {{ toYaml $annotations | nindent 2 }}
{{- end }}
{{- end }}

{{/*
Return the vm.spec.dataVolumeTemplates object
*/}}

{{- define "vm.spec.dataVolumeTemplates" -}}

{{- if .Values.vm.dataVolumeTemplates}}
  dataVolumeTemplates: {{ toYaml .Values.vm.dataVolumeTemplates | nindent 4 }}
{{- end }}
{{- end }}
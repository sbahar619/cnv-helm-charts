{{/*
Return the PerformanceProfile.spec object
*/}}

{{- define "PerformanceProfile.spec" -}}

  {{- if .Values.PerformanceProfile -}}
    {{ $PerformanceProfile := .Values.PerformanceProfile }}

    {{- if $PerformanceProfile.cpu -}}
      cpu: {{- include "PerformanceProfile.spec.cpu" . }}
    {{- end }}

    {{- if $PerformanceProfile.globallyDisableIrqLoadBalancing -}}
      globallyDisableIrqLoadBalancing: {{- include "PerformanceProfile.spec.globallyDisableIrqLoadBalancing" . }}
    {{- end }}

    {{- if $PerformanceProfile.hugepages -}}
      hugepages: {{- include "PerformanceProfile.spec.hugepages" . }}
    {{- end }}
    
    {{- if $PerformanceProfile.realTimeKernel -}}
      realTimeKernel: {{- include "PerformanceProfile.spec.realTimeKernel" . }}
    {{- end }}

    {{- if $PerformanceProfile.workloadHints -}}
      workloadHints: {{- include "PerformanceProfile.spec.workloadHints" . }}
    {{- end }}

    {{- if $PerformanceProfile.nodeSelector -}}
      nodeSelector: {{- include "PerformanceProfile.spec.nodeSelector" . }}
    {{- end }}

    {{- if $PerformanceProfile.numa -}}
      numa: {{- include "PerformanceProfile.spec.numa" . }}
    {{- end }}

  {{- end }}
{{- end }}

{{/*
Return the PerformanceProfile.spec.cpu object
*/}}

{{- define "PerformanceProfile.spec.cpu" -}}
  {{- $cpu := .Values.PerformanceProfile.cpu }}
  isolated: {{ $cpu.isolated }}
  reserved: {{ $cpu.reserved }}
{{ end -}}

{{/*
Return the PerformanceProfile.spec.globallyDisableIrqLoadBalancing object
*/}}

{{- define "PerformanceProfile.spec.globallyDisableIrqLoadBalancing" -}}
  {{- $globallyDisableIrqLoadBalancing := .Values.PerformanceProfile.globallyDisableIrqLoadBalancing }} {{ $globallyDisableIrqLoadBalancing }}
{{ end -}}

{{/*
Return the PerformanceProfile.spec.hugepages object
*/}}

{{- define "PerformanceProfile.spec.hugepages" -}}
  {{- $hugepages := .Values.PerformanceProfile.hugepages }}
  defaultHugepagesSize: {{ $hugepages.defaultHugepagesSize }}
  {{- include "PerformanceProfile.spec.hugepages.pages" . }}
{{- end }}

{{/*
Return the PerformanceProfile.spec.hugepages.pages object
*/}}

{{- define "PerformanceProfile.spec.hugepages.pages" -}}
  {{- $pages := .Values.PerformanceProfile.hugepages.pages }}
  pages:
  {{- range $pages }}
    - count: {{ .count }}
      size: {{ .size }}
  {{- end }}
{{ end -}}

{{/*
Return the PerformanceProfile.spec.realTimeKernel object
*/}}

{{- define "PerformanceProfile.spec.realTimeKernel" -}}
  {{- $realTimeKernel := .Values.PerformanceProfile.realTimeKernel }}
  enabled: {{ $realTimeKernel.enabled }}
{{ end -}}

{{/*
Return the PerformanceProfile.spec.workloadHints object
*/}}

{{- define "PerformanceProfile.spec.workloadHints" -}}
  {{- $workloadHints := .Values.PerformanceProfile.workloadHints }}
  highPowerConsumption: {{ $workloadHints.highPowerConsumption }}
  realTime: {{ $workloadHints.realTime }}
{{ end -}}

{{/*
Return the PerformanceProfile.spec.nodeSelector object
*/}}

{{- define "PerformanceProfile.spec.nodeSelector" -}}
  {{- $nodeSelector := .Values.PerformanceProfile.nodeSelector }}
  {{ $nodeSelector.key }}: {{ default "" $nodeSelector.value | quote }}
{{ end -}}

{{/*
Return the PerformanceProfile.spec.numa object
*/}}

{{- define "PerformanceProfile.spec.numa" -}}
  {{- $numa := .Values.PerformanceProfile.numa }}
  topologyPolicy: {{ $numa.topologyPolicy }}
{{ end -}}
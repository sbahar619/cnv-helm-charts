{{/*
Return the PerformanceProfile.spec object
*/}}

{{- define "PerformanceProfile.spec" -}}
{{- if .Values.PerformanceProfile }}
{{- $PerformanceProfile := .Values.PerformanceProfile }}
{{- if $PerformanceProfile.cpu }}
cpu:
  {{- include "PerformanceProfile.spec.cpu" . | indent 2 }}
{{- end }}
{{- if $PerformanceProfile.globallyDisableIrqLoadBalancing }}
globallyDisableIrqLoadBalancing: {{ $PerformanceProfile.globallyDisableIrqLoadBalancing }}
{{- end }}
{{- if $PerformanceProfile.hugepages }}
hugepages:
{{- include "PerformanceProfile.spec.hugepages" . | indent 2 }}
{{- end }}
{{- if $PerformanceProfile.realTimeKernel }}
realTimeKernel:
{{- $realTimeKernel := $PerformanceProfile.realTimeKernel }}
  enabled: {{ $realTimeKernel.enabled }}
{{- end }}
{{- if $PerformanceProfile.workloadHints }}
workloadHints:
{{- $workloadHints := $PerformanceProfile.workloadHints }}
  highPowerConsumption: {{ $workloadHints.highPowerConsumption }}
  realTime: {{ $workloadHints.realTime }}
{{- end }}
{{- if $PerformanceProfile.nodeSelector }}
nodeSelector:
  {{- $nodeSelector := $PerformanceProfile.nodeSelector }}
  {{ $nodeSelector.key }}: {{ default "" $nodeSelector.value | quote }}
{{- end }}
{{- if $PerformanceProfile.numa }}
numa:
  {{- $numa := $PerformanceProfile.numa }}
  topologyPolicy: {{ $numa.topologyPolicy }}
{{- end }}
{{- end }}
{{- end }}
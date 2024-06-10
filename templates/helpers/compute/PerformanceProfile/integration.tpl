{{/*
Return the PerformanceProfile.spec object
*/}}

{{- define "PerformanceProfile.spec" -}}
{{- $PerformanceProfile := .Values.PerformanceProfile }}
cpu:
  {{- include "PerformanceProfile.spec.cpu" . | indent 2 }}
globallyDisableIrqLoadBalancing: {{ $PerformanceProfile.globallyDisableIrqLoadBalancing }}
hugepages:
{{- include "PerformanceProfile.spec.hugepages" . | indent 2 }}
realTimeKernel:
{{- $realTimeKernel := $PerformanceProfile.realTimeKernel }}
  enabled: {{ $realTimeKernel.enabled }}
workloadHints:
{{- $workloadHints := $PerformanceProfile.workloadHints }}
  highPowerConsumption: {{ $workloadHints.highPowerConsumption }}
  realTime: {{ $workloadHints.realTime }}
nodeSelector:
  {{- $nodeSelector := $PerformanceProfile.nodeSelector }}
  {{ $nodeSelector.key }}: {{ default "" $nodeSelector.value | quote }}
numa:
  {{- $numa := $PerformanceProfile.numa }}
  topologyPolicy: {{ $numa.topologyPolicy }}
{{- end }}
{{/*
Return the vm.spec.template.spec.domain object
*/}}

{{- define "vm.spec.template.spec.domain" -}}
{{- if .domain }}
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
  {{- if .template.metadata }}
    metadata:
      {{- include "vm.spec.template.metadata" . }}
  {{- end }}
  {{- if .template.spec }}
    spec:
      {{- include "vm.spec.template.spec" . }}
  {{- end }}
{{- end }}

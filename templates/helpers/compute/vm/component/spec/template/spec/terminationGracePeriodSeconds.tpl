{{/*
Return the vm.spec.template.spec.terminationGracePeriodSeconds object
*/}}

{{- define "vm.spec.template.spec.terminationGracePeriodSeconds" -}}
{{- if and .template .template.spec }}
{{- $terminationGracePeriodSeconds := .template.spec.terminationGracePeriodSeconds }}
terminationGracePeriodSeconds: {{ $terminationGracePeriodSeconds }}
{{- end }}
{{- end }}
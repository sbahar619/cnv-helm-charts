{{/*
Return the dv.spec.pvc.accessModes object
*/}}

{{- define "dv.spec.pvc.accessModes" -}}
{{- if and .Values.dv .Values.dv.pvc .Values.dv.pvc.accessModes }}
{{- range .Values.dv.pvc.accessModes }}
- {{ . }}
{{- end }}
{{- end }}
{{- end }}

{{/*
Return the dv.spec.source.registry object
*/}}

{{- define "dv.spec.source.registry" -}}
{{- if and .Values.dv .Values.dv.source .Values.dv.source.registry }}
{{- $registry := .Values.dv.source.registry }}
registry:
  {{- if $registry.url }}
  url: {{ $registry.url }}
  {{- end }}
  {{- if $registry.secretRef }}
  secretRef: {{ $registry.secretRef }}
  {{- end }}
  {{- if $registry.pullMethod }}
  pullMethod: {{ $registry.pullMethod }}
  {{- end }}
{{- end }}
{{- end }}

{{/*
Return the dv.spec.source.blank object
*/}}

{{- define "dv.spec.source.blank" -}}
{{- if and .Values.dv.source .Values.dv.source.blank }}
blank: {}
{{- end }}

{{- end }}

{{/*
Return the dv.spec.source.blank object
*/}}

{{- define "dv.spec.sourceRef" -}}

{{- if .Values.dv.sourceRef }}
{{- $sourceRef := .Values.dv.sourceRef }}
sourceRef:

  {{- if $sourceRef.kind }}
  kind: {{ $sourceRef.kind }}
  {{- end }}

  {{- if $sourceRef.name }}
  name: {{ $sourceRef.name }}
  {{- end }}

  {{- if $sourceRef.namespace }}
  namespace: {{ $sourceRef.namespace }}
  {{- end }}

{{- end }}
{{- end }}

{{/*
Return the dv.spec.storage object
*/}}

{{- define "dv.spec.storage" -}}

{{- if .Values.dv.storage }}
{{- $storage := .Values.dv.storage }}
storage:

  {{- if $storage.accessModes }}
  accessModes:
      {{- include "dv.spec.pvc.accessModes" . | indent 4 }}
  {{- end }}

  {{- if $storage.storageClassName }}
  storageClassName: {{  $storage.storageClassName }}
  {{- end }}

  {{- if $storage.volumeMode }}
  volumeMode: {{  $storage.volumeMode }}
  {{- end }}

  {{- if and $storage.resources $storage.resources.requests $storage.resources.requests.storage }}
  resources:
    requests:
      storage: {{  $storage.resources.requests.storage }}
  {{- end }}

{{- end }}
{{- end }}

{{/*
Return the dv.spec.storage.accessModes object
*/}}

{{- define "dv.spec.storage.accessModes" -}}
{{- if and .Values.dv .Values.dv.storage .Values.dv.storage.accessModes }}
{{- $accessModes := .Values.dv.storage.accessModes }}
{{- range  $accessModes }}
- {{ . }}
{{- end }}
{{- end }}
{{- end }}
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
  storageClassName: {{ $storage.storageClassName }}
  {{- end }}

  {{- if $storage.volumeMode }}
  volumeMode: {{ $storage.volumeMode }}
  {{- end }}

  {{- if and $storage.resources $storage.resources.requests $storage.resources.requests.storage }}
  resources:
    requests:
      storage: {{ $storage.resources.requests.storage }}
  {{- end }}

{{- end }}
{{- end }}

{{/*
Return the dv.spec.storage.accessModes object
*/}}

{{- define "dv.spec.storage.accessModes" -}}
{{- if and .Values.dv .Values.dv.storage .Values.dv.storage.accessModes }}
{{- $storage := .Values.dv.storage }}
{{- range  $storage.accessModes }}
- {{ . }}
{{- end }}
{{- end }}
{{- end }}

{{/*
Return the dv.spec.pvc object
*/}}

{{- define "dv.spec.pvc" -}}

{{- if .Values.dv.pvc }}
{{- $pvc := .Values.dv.pvc }}
storage:

  {{- if $pvc.accessModes }}
  accessModes:
      {{- include "dv.spec.pvc.accessModes" . | indent 4 }}
  {{- end }}

  {{- if $pvc.storageClassName }}
  storageClassName: {{ $pvc.storageClassName }}
  {{- end }}

  {{- if $pvc.volumeMode }}
  volumeMode: {{ $pvc.volumeMode }}
  {{- end }}

  {{- if and $pvc.resources $pvc.resources.requests $pvc.resources.requests.storage }}
  resources:
    requests:
      storage: {{ $pvc.resources.requests.storage }}
  {{- end }}

{{- end }}
{{- end }}

{{/*
Return the dv.spec.source.pvc object
*/}}

{{- define "dv.spec.source.pvc" -}}

{{- if .Values.dv.source.pvc }}
{{- $pvc := .Values.dv.source.pvc }}
pvc:

  {{- if $pvc.name }}
  name: {{ $pvc.name }}
  {{- end }}

  {{- if $pvc.namespace }}
  namespace: {{ $pvc.namespace }}
  {{- end }}

{{- end }}
{{- end }}


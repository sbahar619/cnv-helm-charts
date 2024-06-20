{{/*
Function to render a key-value pair if the value is defined.
Parameters:
  - .key: The key to be included in the output.
  - .value: The value to be included in the output if it is defined.
Usage:
  This function helps to conditionally render key-value pairs in Helm templates,
  ensuring that only non-null and non-empty values are included.
*/}}

{{- define "renderKeyValuePair" -}}
  {{- if .value }}
  {{ .key }}: {{ .value }}
  {{- end }}
{{- end }}
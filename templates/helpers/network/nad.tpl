{{/*
Return the nad.spec.config object
*/}}

{{- define "nad.spec.config" -}}
{{- if and .Values.nad .Values.nad.network }}
{{- $network := .Values.nad.network }}
    '{
      {{- if $network.cniVersion }}
      "cniVersion": "{{ $network.cniVersion }}",
      {{- end }}
      {{- if $network.name }}
      "name": "{{ $network.name }}",
      {{- end }}
      {{- if $network.type }}
      "type": "{{ $network.type }}",
      {{- end }}
      {{- if $network.bridge }}
      "bridge": "{{ $network.bridge }}",
      {{- end }}
      {{- if $network.macspoofchk }}
      "macspoofchk": {{ $network.macspoofchk | toString }},
      {{- end }}
      {{- if $network.ipam }}
      "ipam": {{ $network.ipam }},
      {{- end }}
      {{- if $network.vlan }}
      "vlan": {{ $network.vlan }},
      {{- end }}
      {{- if $network.preserveDefaultVlan }}
      "preserveDefaultVlan": {{ $network.preserveDefaultVlan | toString }}
      {{- end }}
    }'
{{- end }}
{{- end }}
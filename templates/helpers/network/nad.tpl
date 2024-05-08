{{/*
Return the nad.spec.config object
*/}}

{{- define "nad.spec.config" -}}
{{- $network := .Values.nad.network }}
    '{
      "cniVersion": "{{ $network.cniVersion }}",
      "name": "{{ $network.name }}",
      "type": "{{ $network.type }}",
      "bridge": "{{ $network.bridge }}",
      "macspoofchk": {{ $network.macspoofchk | toString }},
      {{- if $network.ipam.enable }}
      "ipam": {{ $network.ipam.value }},
      {{- end }}
      {{- if $network.vlan.enable }}
      "vlan": {{ $network.vlan.value }},
      {{- end }}
      {{- if $network.preserveDefaultVlan.enable }}
      "preserveDefaultVlan": {{ $network.preserveDefaultVlan.value | toString }}
      {{- end }}
    }'
{{- end }}
{{/*
Copyright 2017 The Openstack-Helm Authors.

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

   http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
*/}}

# This function returns key value pair in the INI format (key = value)
# as needed by openstack config files
#
# Sample key value pair format:
# conf:
#   libvirt:
#     log_level: 3
# Usage:
# { include "helm-toolkit.utils.to_kv_list" .Values.conf.libvirt }
# returns: log_level = 3

{{- define "helm-toolkit.utils.to_kv_list" -}}
{{- range $key, $value :=  . -}}
{{- if kindIs "slice" $value }}
{{ $key }} = [{{ range $value -}}
{{- if regexMatch "^[0-9]+$" . -}}
{{- . -}},
{{- else -}}
{{- . | quote -}},
{{- end }}
{{- end }}]
{{- else if kindIs "string" $value }}
{{- if regexMatch "^[0-9]+$" $value }}
{{ $key }} = {{ $value }}
{{- else }}
{{ $key }} = {{ $value | quote }}
{{- end }}
{{- else }}
{{ $key }} = {{ $value }}
{{- end }}
{{- end -}}
{{- end -}}

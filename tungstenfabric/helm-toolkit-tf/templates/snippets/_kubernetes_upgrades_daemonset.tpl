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

{{- define "helm-toolkit.snippets.kubernetes_upgrades_daemonset" -}}
{{- $envAll := index . 0 -}}
{{- $component := index . 1 -}}
{{- $upgradeMap := index $envAll.Values.pod.lifecycle.upgrades.daemonsets $component -}}
{{- $pod_replacement_strategy := $envAll.Values.pod.lifecycle.upgrades.daemonsets.pod_replacement_strategy -}}
{{- with $upgradeMap -}}
{{- if .enabled }}
minReadySeconds: {{ .min_ready_seconds }}
updateStrategy:
  type: {{ $pod_replacement_strategy }}
  {{- if $pod_replacement_strategy }}
  {{- if eq $pod_replacement_strategy "RollingUpdate" }}
  rollingUpdate:
    maxUnavailable: {{ .max_unavailable }}
  {{- end }}
  {{- end }}
{{- end }}
{{- end -}}
{{- end -}}

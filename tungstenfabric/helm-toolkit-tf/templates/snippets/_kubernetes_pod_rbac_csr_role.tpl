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

{{- define "helm-toolkit.snippets.kubernetes_pod_rbac_csr_role" -}}
{{- $envAll := index . 0 -}}
{{- $saName := index . 1 -}}
{{- $saNamespace := $envAll.Release.Namespace }}
{{- $releaseName := $envAll.Release.Name }}
---
kind: ClusterRole
apiVersion: rbac.authorization.k8s.io/v1beta1
metadata:
  name: {{ $releaseName }}-{{ $saNamespace }}-{{ $saName }}-certs
  namespace: {{ $saNamespace }}
rules:
  - apiGroups: ["certificates.k8s.io"]
    resources: ["certificatesigningrequests", "certificatesigningrequests/approval"]
    verbs: ["*"]
---
apiVersion: rbac.authorization.k8s.io/v1beta1
kind: ClusterRoleBinding
metadata:
  name: {{ $releaseName }}-{{ $saName }}-certs
  namespace: {{ $saNamespace }}
roleRef:
  apiGroup: rbac.authorization.k8s.io
  kind: ClusterRole
  name: {{ $releaseName }}-{{ $saNamespace }}-{{ $saName }}-certs
subjects:
  - kind: ServiceAccount
    name: {{ $saName }}
    namespace: {{ $saNamespace }}
{{- end -}}

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

# This function returns endpoint "<namespace>:<name>" pair from an endpoint
# definition. This is used in kubernetes-entrypoint to support dependencies
# between different services in different namespaces.
# returns: the endpoint namespace and the service name, delimited by a colon

{{- define "helm-toolkit.endpoints.service_name_endpoint_with_namespace_lookup" -}}
{{- $type := index . 0 -}}
{{- $endpoint := index . 1 -}}
{{- $context := index . 2 -}}
{{- $typeYamlSafe := $type | replace "-" "_" }}
{{- $endpointMap := index $context.Values.endpoints $typeYamlSafe }}
{{- with $endpointMap -}}
{{- $endpointScheme := .scheme }}
{{- $endpointName := index .hosts $endpoint | default .hosts.default}}
{{- $endpointNamespace := .namespace | default $context.Release.Namespace }}
{{- printf "%s:%s" $endpointNamespace $endpointName -}}
{{- end -}}
{{- end -}}

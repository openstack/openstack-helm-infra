#!/bin/bash

#    Licensed under the Apache License, Version 2.0 (the "License"); you may
#    not use this file except in compliance with the License. You may obtain
#    a copy of the License at
#
#         http://www.apache.org/licenses/LICENSE-2.0
#
#    Unless required by applicable law or agreed to in writing, software
#    distributed under the License is distributed on an "AS IS" BASIS, WITHOUT
#    WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the
#    License for the specific language governing permissions and limitations
#    under the License.

set -xe

: ${OSH_INFRA_EXTRA_HELM_ARGS_RABBITMQ:="$(./tools/deployment/common/get-values-overrides.sh rabbitmq)"}

#NOTE: Lint and package chart
make rabbitmq

#NOTE: Deploy command
: ${OSH_EXTRA_HELM_ARGS:=""}
helm upgrade --install rabbitmq ./rabbitmq \
    --namespace=openstack \
    --recreate-pods \
    --force \
    --set network.management.ingress.classes.namespace=nginx \
    ${OSH_INFRA_EXTRA_HELM_ARGS} \
    ${OSH_INFRA_EXTRA_HELM_ARGS_RABBITMQ}

#NOTE: Wait for deploy
./tools/deployment/common/wait-for-pods.sh openstack

helm test rabbitmq --namespace openstack

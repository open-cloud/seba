{{/* vim: set filetype=mustache: */}}
{{/*
Copyright 2018-present Open Networking Foundation

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
{{- define "volt.serviceTosca" -}}
tosca_definitions_version: tosca_simple_yaml_1_0
description: Set up VOLT service
imports:
  - custom_types/voltservice.yaml

topology_template:
  node_templates:
    service#volt:
      type: tosca.nodes.VOLTService
      properties:
        name: volt
        voltha_url: voltha.voltha.svc.cluster.local
        voltha_port: 8882
        onos_voltha_url: onos-voltha-ui.voltha.svc.cluster.local
        onos_voltha_port: 8181
        onos_voltha_user: karaf
        onos_voltha_pass: karaf
{{- end -}}

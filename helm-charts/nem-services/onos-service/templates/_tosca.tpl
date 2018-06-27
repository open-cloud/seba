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
{{- define "onos-service.fabricAppTosca" -}}
tosca_definitions_version: tosca_simple_yaml_1_0
imports:
  - custom_types/onosapp.yaml
  - custom_types/onosservice.yaml
description: ONOS service and app for fabric
topology_template:
  node_templates:
    service#ONOS_Fabric:
      type: tosca.nodes.ONOSService
      properties:
          name: ONOS_Fabric
          kind: platform
          rest_hostname: onos-fabric-ui
          rest_port: 8181

    onos_app#segmentrouting:
      type: tosca.nodes.ONOSApp
      properties:
        name: org.onosproject.segmentrouting
        app_id: org.onosproject.segmentrouting
      requirements:
        - owner:
            node: service#ONOS_Fabric
            relationship: tosca.relationships.BelongsToOne

    onos_app#vrouter:
      type: tosca.nodes.ONOSApp
      properties:
        name: org.onosproject.vrouter
        app_id: org.onosproject.vrouter
      requirements:
        - owner:
            node: service#ONOS_Fabric
            relationship: tosca.relationships.BelongsToOne

    onos_app#netcfghostprovider:
      type: tosca.nodes.ONOSApp
      properties:
        name: org.onosproject.netcfghostprovider
        app_id: org.onosproject.netcfghostprovider
      requirements:
        - owner:
            node: service#ONOS_Fabric
            relationship: tosca.relationships.BelongsToOne

    onos_app#openflow:
      type: tosca.nodes.ONOSApp
      properties:
        name: org.onosproject.openflow
        app_id: org.onosproject.openflow
      requirements:
        - owner:
            node: service#ONOS_Fabric
            relationship: tosca.relationships.BelongsToOne
{{- end -}}

{{- define "onos-service.vtnAppTosca" -}}
tosca_definitions_version: tosca_simple_yaml_1_0

imports:
   - custom_types/onosapp.yaml
   - custom_types/onosservice.yaml
   - custom_types/serviceinstanceattribute.yaml

description: Configures the VTN ONOS service

topology_template:
  node_templates:

    service#ONOS_CORD:
      type: tosca.nodes.ONOSService
      properties:
          name: ONOS_CORD
          kind: platform
          rest_hostname: onos-cord-ui
          rest_port: 8181

    onos_app#openflow:
      type: tosca.nodes.ONOSApp
      properties:
        name: org.onosproject.openflow
        app_id: org.onosproject.openflow
      requirements:
        - owner:
            node: service#ONOS_CORD
            relationship: tosca.relationships.BelongsToOne

    onos_app#dhcp:
      type: tosca.nodes.ONOSApp
      properties:
        name: org.onosproject.dhcp
        app_id: org.onosproject.dhcp
      requirements:
        - owner:
            node: service#ONOS_CORD
            relationship: tosca.relationships.BelongsToOne

    onos_app#cord-config:
      type: tosca.nodes.ONOSApp
      properties:
        name: cord-config
        app_id: org.opencord.cord-config
        url: {{ .cordConfigAppURL }}
        version: 1.4.0
        dependencies: org.onosproject.openflow, org.onosproject.dhcp
      requirements:
        - owner:
            node: service#ONOS_CORD
            relationship: tosca.relationships.BelongsToOne

    onos_app#vtn:
      type: tosca.nodes.ONOSApp
      properties:
        name: vtn
        app_id: org.opencord.vtn
        url: {{ .vtnAppURL }}
        version: 1.6.0
      requirements:
        - owner:
            node: service#ONOS_CORD
            relationship: tosca.relationships.BelongsToOne
{{- end -}}

{{- define "onos-service.volthaOnosTosca" -}}
tosca_definitions_version: tosca_simple_yaml_1_0

imports:
   - custom_types/onosapp.yaml
   - custom_types/onosservice.yaml
   - custom_types/serviceinstanceattribute.yaml

description: Configures the VTN ONOS service

topology_template:
  node_templates:

    service#ONOS_CORD:
      type: tosca.nodes.ONOSService
      properties:
          name: ONOS_VOLTHA
          kind: platform
          rest_hostname: onos-voltha-ui.voltha.svc.cluster.local
          rest_port: 8181

    onos_app#olt:
      type: tosca.nodes.ONOSApp
      properties:
        name: org.opencord.olt
        app_id: org.opencord.olt
        version: 1.4.0
      requirements:
        - owner:
            node: service#ONOS_CORD
            relationship: tosca.relationships.BelongsToOne

    # CORD-Configuration
    cord-config-attr:
      type: tosca.nodes.ServiceInstanceAttribute
      properties:
        name: /onos/v1/network/configuration/apps/org.opencord.olt
        value: >
          {
            "kafka" : {
              "bootstrapServers" : "cord-kafka.default.svc.cluster.local:9092"
            }
          }
      requirements:
        - service_instance:
            node: onos_app#olt
            relationship: tosca.relationships.BelongsToOne
{{- end -}}
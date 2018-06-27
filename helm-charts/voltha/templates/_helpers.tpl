{{- /*
Copyright 2017-present Open Networking Foundation

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
*/ -}}

{{- define "voltha-shovel.cmd" }}
- "/shovel/shovel/main.py"
- "--kafka={{ .Values.kafkaReleaseName }}.default.svc.cluster.local"
- "--host=grafana.voltha.svc.cluster.local"
- "--topic=voltha.kpis"
{{- end }}

{{- define "voltha-dashd.cmd" }}
- "/dashd/dashd/main.py"
- "--kafka={{ .Values.kafkaReleaseName }}.default.svc.cluster.local"
- "--grafana_url=http://admin:admin@grafana.$(NAMESPACE).svc.cluster.local:80/api"
- "--topic=voltha.kpis"
{{- end }}

{{- define "voltha-vcore.cmd" }}
- "voltha/voltha/main.py"
- "-v"
- "--etcd=etcd-cluster.default.svc.cluster.local:2379"
- "--kafka={{ .Values.kafkaReleaseName }}.default.svc.cluster.local"
- "--rest-port=8880"
- "--grpc-port=50556"
- "--interface=eth1"
- "--backend=etcd"
- "--pon-subnet=10.38.0.0/12"
- "--ponsim-comm=grpc"
{{- end }}



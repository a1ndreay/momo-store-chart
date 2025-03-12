{{- define "prometheus.alb.annotations" -}}
  ingress.alb.yc.io/subnets: {{ .Values.global.alb.subnets }} # список_идентификаторов_подсетей
  ingress.alb.yc.io/security-groups: {{ .Values.global.alb.security_groups }} # список_идентификаторов_групп_безопасности
  ingress.alb.yc.io/external-ipv4-address: {{ .Values.global.alb.external_ipv4_address }} # способ_назначения_IP-адреса
  ingress.alb.yc.io/group-name: {{ .Values.global.alb.group_name }} # имя_группы_ресурсов_Ingress
{{- end -}}
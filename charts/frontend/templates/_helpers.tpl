{{- define "frontend.labels" -}}
  labels:
    app.kubernetes.io/name: {{ .Chart.Name }}
    app.kubernetes.io/version: {{ .Values.global.frontend.version }}
    app.kubernetes.io/managed-by: {{ .Release.Service }}
    helm.sh/chart: {{ .Chart.Name }}-{{ .Chart.Version }}
    helm.sh/release-namespace: {{ .Release.Namespace }}
    helm.sh/release-name: {{ .Release.Name }}
{{- end -}}

{{- define "alb.annotations" -}}
  ingress.alb.yc.io/subnets: {{ .Values.global.alb. }} # список_идентификаторов_подсетей
  ingress.alb.yc.io/security-groups: {{ .Values.global.alb. }} # список_идентификаторов_групп_безопасности
  ingress.alb.yc.io/external-ipv4-address: {{ .Values.global.alb. }} # способ_назначения_IP-адреса
  ingress.alb.yc.io/group-name: {{ .Values.global.alb. }} # имя_группы_ресурсов_Ingress
{{- end -}}
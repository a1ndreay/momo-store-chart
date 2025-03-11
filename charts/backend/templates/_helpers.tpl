{{- define "backend.labels" -}}
  labels:
    app.kubernetes.io/name: {{ .Chart.Name }}
    app.kubernetes.io/version: {{ .Values.global.backend.version }}
    app.kubernetes.io/managed-by: {{ .Release.Service }}
    helm.sh/chart: {{ .Chart.Name }}-{{ .Chart.Version }}
    helm.sh/release-namespace: {{ .Release.Namespace }}
    helm.sh/release-name: {{ .Release.Name }}
{{- end -}}
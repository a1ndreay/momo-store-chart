{{- define "imagePullSecret" }}
{{- if or (kindIs "float64" .Values.global.imageCredentials.port ) (kindIs "int" .Values.global.imageCredentials.port ) }}
{{- with .Values.global.imageCredentials }}
{{- printf "{\n\t\"auths\": {\n\t\t\"%s:%s\":{\n\t\t\t\"auth\": \"%s\"\n\t\t}\n\t}\n}" .registry ( .port | toString ) (printf "%s:%s" .username .password | b64enc) | b64enc }}
{{- end }}
{{- else if kindIs "string" .Values.global.imageCredentials.port }}
{{- with .Values.global.imageCredentials }}
{{- printf "{\n\t\"auths\": {\n\t\t\"%s:%s\":{\n\t\t\t\"auth\": \"%s\"\n\t\t}\n\t}\n}" .registry ( .port ) (printf "%s:%s" .username
 .password | b64enc) | b64enc }}
{{- end }}
{{- else }}
{{- end }}
{{- end }}

{{- define "frontend.labels" -}}
  labels:
    app.kubernetes.io/name: {{ .Chart.Name }}
    app.kubernetes.io/version: {{ .Values.global.frontend.version }}
    app.kubernetes.io/managed-by: {{ .Release.Service }}
    helm.sh/chart: {{ .Chart.Name }}-{{ .Chart.Version }}
    helm.sh/release-namespace: {{ .Release.Namespace }}
    helm.sh/release-name: {{ .Release.Name }}
{{- end -}}
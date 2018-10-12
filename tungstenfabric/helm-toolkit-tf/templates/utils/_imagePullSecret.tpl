{{- define "helm-toolkit.utils.imagePullSecret" }}
{{- printf "{\"auths\": {\"%s\": {\"auth\": \"%s\"}}}" .Values.global.images.imageCredentials.registry (printf "%s:%s" .Values.global.images.imageCredentials.username .Values.global.images.imageCredentials.password | b64enc) | b64enc }}
{{- end }}

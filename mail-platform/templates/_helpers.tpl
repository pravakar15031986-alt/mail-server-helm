{{/*
Expand the name of the chart.
*/}}
{{- define "mail-platform.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
*/}}
{{- define "mail-platform.fullname" -}}
{{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default .Chart.Name .Values.nameOverride }}
{{- if contains $name .Release.Name }}
{{- .Release.Name | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "mail-platform.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "mail-platform.labels" -}}
helm.sh/chart: {{ include "mail-platform.chart" . }}
{{ include "mail-platform.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "mail-platform.selectorLabels" -}}
app.kubernetes.io/name: {{ include "mail-platform.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Postfix labels
*/}}
{{- define "mail-platform.postfix.labels" -}}
{{ include "mail-platform.labels" . }}
app.kubernetes.io/component: postfix
{{- end }}

{{- define "mail-platform.postfix.selectorLabels" -}}
{{ include "mail-platform.selectorLabels" . }}
app.kubernetes.io/component: postfix
{{- end }}

{{/*
Cyrus IMAP labels
*/}}
{{- define "mail-platform.cyrus.labels" -}}
{{ include "mail-platform.labels" . }}
app.kubernetes.io/component: cyrus-imap
{{- end }}

{{- define "mail-platform.cyrus.selectorLabels" -}}
{{ include "mail-platform.selectorLabels" . }}
app.kubernetes.io/component: cyrus-imap
{{- end }}

{{/*
Amavis labels
*/}}
{{- define "mail-platform.amavis.labels" -}}
{{ include "mail-platform.labels" . }}
app.kubernetes.io/component: amavis
{{- end }}

{{- define "mail-platform.amavis.selectorLabels" -}}
{{ include "mail-platform.selectorLabels" . }}
app.kubernetes.io/component: amavis
{{- end }}

{{/*
SpamAssassin labels
*/}}
{{- define "mail-platform.spamassassin.labels" -}}
{{ include "mail-platform.labels" . }}
app.kubernetes.io/component: spamassassin
{{- end }}

{{- define "mail-platform.spamassassin.selectorLabels" -}}
{{ include "mail-platform.selectorLabels" . }}
app.kubernetes.io/component: spamassassin
{{- end }}

{{/*
ClamAV labels
*/}}
{{- define "mail-platform.clamav.labels" -}}
{{ include "mail-platform.labels" . }}
app.kubernetes.io/component: clamav
{{- end }}

{{- define "mail-platform.clamav.selectorLabels" -}}
{{ include "mail-platform.selectorLabels" . }}
app.kubernetes.io/component: clamav
{{- end }}

{{/*
LDAP labels
*/}}
{{- define "mail-platform.ldap.labels" -}}
{{ include "mail-platform.labels" . }}
app.kubernetes.io/component: ldap
{{- end }}

{{- define "mail-platform.ldap.selectorLabels" -}}
{{ include "mail-platform.selectorLabels" . }}
app.kubernetes.io/component: ldap
{{- end }}

{{/*
Roundcube labels
*/}}
{{- define "mail-platform.roundcube.labels" -}}
{{ include "mail-platform.labels" . }}
app.kubernetes.io/component: roundcube
{{- end }}

{{- define "mail-platform.roundcube.selectorLabels" -}}
{{ include "mail-platform.selectorLabels" . }}
app.kubernetes.io/component: roundcube
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "mail-platform.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "mail-platform.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}

{{/*
Return the proper Storage Class
*/}}
{{- define "mail-platform.storageClass" -}}
{{- if .Values.global.storageClass }}
{{- .Values.global.storageClass }}
{{- else }}
{{- "standard" }}
{{- end }}
{{- end }}

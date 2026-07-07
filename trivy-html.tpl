<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <title>Trivy Scan Report</title>
  <style>
    body { font-family: Arial, sans-serif; margin: 20px; background: #f4f6f9; }
    h1 { color: #333; }
    .vulnerability { background: #fff; padding: 15px; margin-bottom: 10px; border-radius: 4px; border-left: 5px solid #dc3545; }
    .severity { font-weight: bold; color: #dc3545; }
  </style>
</head>
<body>
  <h1>Trivy Scan Report for {{ .Target }}</h1>
  <h3>Generated on: {{ now }}</h3>
  {{- range .Results }}
    <h2>Target: {{ .Target }}</h2>
    {{- if .Vulnerabilities }}
      {{- range .Vulnerabilities }}
        <div class="vulnerability">
          <p><span class="severity">[{{ .Severity }}]</span> <strong>{{ .VulnerabilityID }}</strong> - {{ .PkgName }} ({{ .InstalledVersion }})</p>
          <p>{{ .Title }}</p>
          <p><em>Description:</em> {{ .Description }}</p>
        </div>
      {{- end }}
    {{- else }}
      <p style="color: green; font-weight: bold;">No High or Critical Vulnerabilities Found!</p>
    {{- end }}
  {{- end }}
</body>
</html>

<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
    <title>Trivy Report</title>
    <style>
      * { font-family: Arial, Helvetica, sans-serif; }
      h1 { text-align: center; }
      table, th, td { border: 1px solid black; border-collapse: collapse; padding: .5em; }
      table { margin: 0 auto; width: 90%; }
      .severity { text-align: center; font-weight: bold; color: #fafafa; }
      .severity-LOW { background-color: #5fbb31; }
      .severity-MEDIUM { background-color: #e9c600; }
      .severity-HIGH { background-color: #ff8800; }
      .severity-CRITICAL { background-color: #e40000; }
    </style>
  </head>
  <body>
    <h1>Trivy Vulnerability Report</h1>
    {{- range . }}
    <h2>Target: {{ .Target }}</h2>
    <table>
      <tr style="background-color: #f2f2f2;">
        <th>Package</th>
        <th>Vulnerability ID</th>
        <th>Severity</th>
        <th>Installed Version</th>
        <th>Fixed Version</th>
      </tr>
      {{- if (eq (len .Vulnerabilities) 0) }}
      <tr><td colspan="5" style="text-align:center;">No Vulnerabilities found</td></tr>
      {{- else }}
      {{- range .Vulnerabilities }}
      <tr>
        <td>{{ .PkgName }}</td>
        <td><a href="{{ .PrimaryURL }}" target="_blank">{{ .VulnerabilityID }}</a></td>
        <td class="severity severity-{{ .Vulnerability.Severity }}">{{ .Vulnerability.Severity }}</td>
        <td>{{ .InstalledVersion }}</td>
        <td>{{ .FixedVersion }}</td>
      </tr>
      {{- end }}
      {{- end }}
    </table>
    {{- end }}
  </body>
</html>

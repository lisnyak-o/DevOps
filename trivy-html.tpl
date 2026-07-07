<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
    <title>Trivy Vulnerability Report</title>
    <style>
      body { font-family: Arial, sans-serif; margin: 20px; background-color: #f9f9f9; }
      h1, h2 { text-align: center; color: #333; }
      table { border-collapse: collapse; width: 90%; margin: 20px auto; background-color: #fff; box-shadow: 0 2px 5px rgba(0,0,0,0.1); }
      th, td { border: 1px solid #dddddd; text-align: left; padding: 12px; }
      th { background-color: #f2f2f2; font-weight: bold; }
      tr:nth-child(even) { background-color: #f9f9f9; }
      .severity { font-weight: bold; text-align: center; color: #fff; border-radius: 4px; padding: 4px; }
      .severity-LOW { background-color: #5fbb31; }
      .severity-MEDIUM { background-color: #e9c600; color: #333; }
      .severity-HIGH { background-color: #ff8800; }
      .severity-CRITICAL { background-color: #e40000; }
    </style>
  </head>
  <body>
    <h1>Trivy Security Scan Report</h1>
    {{- range . }}
    <h2>Target: {{ .Target }}</h2>
    <table>
      <thead>
        <tr>
          <th>Package</th>
          <th>Vulnerability ID</th>
          <th>Severity</th>
          <th>Installed Version</th>
          <th>Fixed Version</th>
        </tr>
      </thead>
      <tbody>
      {{- if (eq (len .Vulnerabilities) 0) }}
        <tr><td colspan="5" style="text-align:center;">No Vulnerabilities found</td></tr>
      {{- else }}
      {{- range .Vulnerabilities }}
        <tr>
          <td><strong>{{ .PkgName }}</strong></td>
          <td><a href="{{ .PrimaryURL }}" target="_blank">{{ .VulnerabilityID }}</a></td>
          <td><div class="severity severity-{{ .Vulnerability.Severity }}">{{ .Vulnerability.Severity }}</div></td>
          <td>{{ .InstalledVersion }}</td>
          <td>{{ .FixedVersion }}</td>
        </tr>
      {{- end }}
      {{- end }}
      </tbody>
    </table>
    {{- end }}
  </body>
</html>

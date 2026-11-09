Add-Type -AssemblyName 'System.Data'
$connStr = 'Server=sona.database.windows.net;Database=SONA;User Id=sona;Password=qy3P0twDk;Encrypt=True;TrustServerCertificate=True;'
$conn = New-Object System.Data.SqlClient.SqlConnection($connStr)
$conn.Open()
$cmd = $conn.CreateCommand()
$cmd.CommandText = 'SELECT ClassID FROM mClass ORDER BY ClassID'
$adapter = New-Object System.Data.SqlClient.SqlDataAdapter($cmd)
$dt = New-Object System.Data.DataTable
$adapter.Fill($dt) | Out-Null
foreach ($r in $dt.Rows) {
    Write-Host $r['ClassID']
}
$conn.Close()

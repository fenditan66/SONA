Add-Type -AssemblyName 'System.Data'
$connStr = 'Server=sona.database.windows.net;Database=SONA;User Id=sona;Password=qy3P0twDk;Encrypt=True;TrustServerCertificate=True;'
$conn = New-Object System.Data.SqlClient.SqlConnection($connStr)
$conn.Open()

$cmd = $conn.CreateCommand()
$cmd.CommandText = @"
SELECT p.ID, p.PaymentID, p.JenisPayment, p.StudentID, s.StudentID as StudentName, p.Status, p.Nominal, p.InvoiceNo, p.PeriodeYear, p.PeriodeMonth
FROM mPayment p
LEFT JOIN mStudent s ON p.StudentID = s.StudentID AND p.Plant = s.Plant
WHERE p.Plant = 'BTC' AND p.JenisPayment != 'TUITION FEE' AND p.PeriodeYear = '2026' AND p.PeriodeMonth = '10'
"@
$adapter = New-Object System.Data.SqlClient.SqlDataAdapter($cmd)
$dt = New-Object System.Data.DataTable
$adapter.Fill($dt) | Out-Null

Write-Host "Found $($dt.Rows.Count) rows in October:"
foreach ($r in $dt.Rows) {
    if ($r["StudentID"] -like "*Candice*") {
        Write-Host "Candice:" $r["ID"] $r["PaymentID"] $r["JenisPayment"] $r["Nominal"] $r["Status"] $r["InvoiceNo"] "Join StudentName:" $r["StudentName"]
    }
}

$conn.Close()

Add-Type -AssemblyName 'System.Data'
$connStr = 'Server=sona.database.windows.net;Database=SONA;User Id=sona;Password=qy3P0twDk;Encrypt=True;TrustServerCertificate=True;'
$conn = New-Object System.Data.SqlClient.SqlConnection($connStr)
$conn.Open()

Write-Host "--- 1. mGeneralNotes where Type = 'Exam' or similar ---"
$cmd1 = $conn.CreateCommand()
$cmd1.CommandText = "SELECT COUNT(*) FROM mGeneralNotes WHERE Type = 'Exam' OR Keterangan LIKE '%Exam%' OR Keterangan LIKE '%Ujian%'"
$cnt1 = $cmd1.ExecuteScalar()
Write-Host "Count in mGeneralNotes: $cnt1"

$cmd1b = $conn.CreateCommand()
$cmd1b.CommandText = "SELECT TOP 10 * FROM mGeneralNotes WHERE Type = 'Exam' OR Keterangan LIKE '%Exam%' OR Keterangan LIKE '%Ujian%' ORDER BY Tanggal DESC"
$adapter1b = New-Object System.Data.SqlClient.SqlDataAdapter($cmd1b)
$dt1b = New-Object System.Data.DataTable
$adapter1b.Fill($dt1b) | Out-Null
foreach ($r in $dt1b.Rows) {
    Write-Host "$($r['NoteID']) | $($r['Plant']) | $($r['StudentID']) | $($r['ClassID']) | $($r['TeacherID']) | $($r['Tanggal']) | $($r['Keterangan'])"
}

Write-Host "`n--- 2. mPayment where JenisPayment = 'EXAM' ---"
$cmd2 = $conn.CreateCommand()
$cmd2.CommandText = "SELECT COUNT(*) FROM mPayment WHERE JenisPayment = 'EXAM'"
$cnt2 = $cmd2.ExecuteScalar()
Write-Host "Count in mPayment: $cnt2"

$cmd2b = $conn.CreateCommand()
$cmd2b.CommandText = "SELECT TOP 10 ID, Plant, StudentID, ClassID, PeriodeYear, PeriodeMonth, TanggalBayar, Nominal, Status, Keterangan FROM mPayment WHERE JenisPayment = 'EXAM' ORDER BY ID DESC"
$adapter2b = New-Object System.Data.SqlClient.SqlDataAdapter($cmd2b)
$dt2b = New-Object System.Data.DataTable
$adapter2b.Fill($dt2b) | Out-Null
foreach ($r in $dt2b.Rows) {
    Write-Host "$($r['ID']) | $($r['Plant']) | $($r['StudentID']) | $($r['ClassID']) | $($r['PeriodeYear'])-$($r['PeriodeMonth']) | $($r['TanggalBayar']) | $($r['Nominal']) | $($r['Status']) | $($r['Keterangan'])"
}

Write-Host "`n--- 3. What was the query in ExamNotesPage before our recent changes? ---"

$conn.Close()

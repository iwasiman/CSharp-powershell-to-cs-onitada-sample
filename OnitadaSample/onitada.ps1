onitada.ps1
# -------------------------------------------------------------------------------------------------------
# おにただアプリの呼び出しスクリプトサンプル
# 実行方法 ./{このファイル} {第1引数：任意の文字列} {第2引数："true"/"false"の文字列}
# sample > ./onitada.ps1 jaku-chara false
# sample > ./onitada.ps1 kyou-chara true
# -------------------------------------------------------------------------------------------------------

$type = $Args[0]
$onitada = $Args[1]
# PowerShellからだと正常に渡せないことがあるので、安全のためひとつの
# 文字列として渡しています。
$serivceArg = $type + "," + $onitada

# C#のSystem.Diagnostics.ProcessStartInfoが、
# プロセスを起動するときに使用する値のセットです。
$pinfo = New-Object System.Diagnostics.ProcessStartInfo
# 実行するexeファイルはフルパスでないと動かないです。パスに日本語が
# 含まれている場合には、スクリプト自体を
# UTF-8+BOM付 もしくは Shift-JIS で保存する必要があります
$pinfo.FileName = "D:\OnitadaSample\bin\Debug\netcoreapp3.1\OnitadaSample.exe"
$pinfo.RedirectStandardError = $true
$pinfo.RedirectStandardOutput = $true
$pinfo.UseShellExecute = $false
$pinfo.Arguments = $serivceArg

# C#のSystem.Diagnostics.Processクラスが、
# 外部アプリケーションを実行できるクラス。
# 先ほどのProcessStartInfoを引数にして処理をスタートします。
# exeを直接実行するのでなくこの方式をとると、
# 実行時の標準出力やエラーコードを取得できます。
$p = New-Object System.Diagnostics.Process
$p.StartInfo = $pinfo
$p.Start() | Out-Null
$p.WaitForExit()

# このクラスのStandardOutputプロパティが、外部アプリケーションの
# 標準出力ストリームを読みとってくれるので出力。
# 終了コードもExitCodeプロパティで取得できます。
$stReader = $p.StandardOutput
$strOutput = $stReader.ReadToEnd() + $p.ExitCode
Write-Host $strOutput


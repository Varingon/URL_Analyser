#URL Analyser
Write-Output "IP Analyser"
$address = Read-Host -Prompt 'What is the URL?'
#Google
$google = 'https://www.google.com/search?hl=en&q=' + $address   
#VirusTotal
$virusTotal = 'https://www.virustotal.com/gui/search/' + $address + '/detection'
#URLScan.io
$urlScan = 'https://urlscan.io/search/#' + $address
#DNS Resolver
$DNS = Resolve-DnsName $address
#URLHaus 
$urlHaus = 'https://urlhaus.abuse.ch/browse.php?search=' + $address
#AbuseIPDB
$IP = $DNS | Select-Object -Property IPAddress | select -ExpandProperty IPAddress
$abuse = 'https://www.abuseipdb.com/check/' + $IP
Write-Output ""
#Website Status
$statusCode = wget $address | % {$_.StatusCode}
if($statusCode -eq 100){
    $status = "Informational Response: the request was received, continuing process"
}
if($statusCode -eq 200){
    $status = "Successful: the request was successfully received, understood, and accepted"
}
if($statusCode -eq 300){
    $status = "Redirection: further action needs to be taken in order to complete the request"
}
if($statusCode -eq 400){
    $status = "Client Error: the request contains bad syntax or cannot be fulfilled"
}
if($statusCode -eq 500){
    $status = "Server Error: the server failed to fulfil an apparently valid request"
}
#Call Variables
start $google
start $urlHaus
start $abuse
start $virusTotal
start $urlScan
Write-Output " " "Status Code = $statusCode" " " "Website status = $status" " " 'DNS Resolver' " " $DNS

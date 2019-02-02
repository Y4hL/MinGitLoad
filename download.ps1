function download()
{
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12

$Destination = $($args[0])

$url = $($args[1])

Invoke-WebRequest -Uri $url -OutFile $Destination
}

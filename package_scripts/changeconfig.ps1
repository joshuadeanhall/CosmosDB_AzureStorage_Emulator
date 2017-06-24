$addrObj = (Get-NetIPAddress -AddressFamily IPV4 -AddressState Preferred -PrefixOrigin Manual | Select IPAddress)
$addr = $addrObj.IPAddress
$config = "C:\Program Files (x86)\Microsoft SDKs\Azure\Storage Emulator\AzureStorageEmulator.exe.config"
$result = "Replacing 127.0.0.1 with " + $addr + " "
echo $result

(get-content $config) -replace "127.0.0.1",$addr | out-file $config

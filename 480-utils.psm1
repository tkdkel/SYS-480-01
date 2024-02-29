function 480Banner() {
  Write-Host "Hello SYS/SEC/NET-480"
}

function 480Connect([string] $server) {
  $conn = $global:DefaultVIServer
  # Are we already connected
  if ($conn){
    $msg = 'Already connected to: {0}' -f $conn
    Write-Host -ForegroundColor Green $msg
  }
  else {
    $conn = Connect-VIServer -Server $server
    # If this fails, let Connect-VIServer handle the encryption
  }
}

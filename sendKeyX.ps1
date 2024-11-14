$wshell = New-Object -ComObject wscript.shell;
$wshell.AppActivate('WebBrowserPassView')
Sleep 2
$wshell.SendKeys("^{a}")

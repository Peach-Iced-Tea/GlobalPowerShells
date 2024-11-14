$wshell = New-Object -ComObject wscript.shell;
$wshell.AppActivate('WebBrowserPassView')
Sleep 5
$wshell.SendKeys("^{a}")
Sleep 5
$wshell.SendKeys("^{s}")
Sleep 1

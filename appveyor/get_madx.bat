setlocal

set madx_repo=http://pypi.coldfix.de/libmadx-dev
set madx_archive=madx-win%ARCH%.7z
set madx_download=%madx_repo%/%madx_archive%

powershell -Command "(New-Object Net.WebClient).DownloadFile($env:madx_download, $env:madx_archive)"

7z x %madx_archive%
move madx-win%ARCH% %1

endlocal

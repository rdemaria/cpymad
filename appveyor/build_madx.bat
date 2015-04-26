setlocal

set madx_version=5.02.05
set madx_archive=madx-%madx_version%.tgz
set madx_extract=madx-%madx_version%
set madx_install=%1
set madx_releases=http://madx.web.cern.ch/madx/releases
set madx_upstream=%madx_releases%/%madx_version%/madx-src.tgz

set link_file=%2
set patchfile=src\CMakeFiles\madxbin.dir\%link_file%
set tempfile=%patchfile%.tmp


if exist %madx_install% (
  goto out
)

if not exist %madx_archive% (
  powershell -Command "(New-Object Net.WebClient).DownloadFile('%madx_upstream%', '%madx_archive%')"
)

if not exist %madx_extract% (
  7z x  %madx_archive%
  7z x  %madx_extract%.tar
  del   %madx_extract%\._* /s
)

if not exist %madx_install% (
  mkdir %madx_extract%\build
  cd    %madx_extract%\build
  cmake -G "MinGW Makefiles" -DBUILD_SHARED_LIBS:BOOL=OFF -DCMAKE_INSTALL_PREFIX=%madx_install% ..

  if not "%link_file%" == "" (
    python %~dp0\replace.py "-lgcc_eh" "" <%patchfile% >%tempfile%
    del %patchfile%
    move %tempfile% %patchfile%
  )

  mingw32-make
  mingw32-make install
)

:out
endlocal

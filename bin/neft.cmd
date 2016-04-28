@IF EXIST "%~dp0\node.exe" (
  NODE_PATH=%cd%;%~dp0\..\ "%~dp0\node.exe"  "%~dp0\neft.js" %*
) ELSE (
  @SETLOCAL
  @SET PATHEXT=%PATHEXT:;.JS;=;%
  @SET NODE_PATH=%cd%;%~dp0\..\
  node  "%~dp0\neft.js" %*
)

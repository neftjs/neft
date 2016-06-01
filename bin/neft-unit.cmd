@IF EXIST "%~dp0\node.exe" (
  NODE_PATH=%cd%;%~dp0\..\;%~dp0\..\node_modules "%~dp0\node.exe"  "%~dp0\neft-unit.js" %*
) ELSE (
  @SETLOCAL
  @SET PATHEXT=%PATHEXT:;.JS;=;%
  @SET NODE_PATH=%cd%;%~dp0\..\;%~dp0\..\node_modules
  node  "%~dp0\neft-unit.js" %*
)

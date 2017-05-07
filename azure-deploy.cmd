@ECHO ON

REM Install Hugo if it's not installed
pushd D:\home\site\deployments\tools 
if not exist Hugo md Hugo
cd Hugo 
if exist bin goto build
md bin
cd bin
:install
curl -o hugo0207.zip -L https://github.com/spf13/hugo/releases/download/v0.20.7/hugo_0.20.7_Windows-64bit.zip
echo Installing Hugo...
SetLocal DisableDelayedExpansion & d:\7zip\7za x hugo0207.zip
if !ERRORLEVEL! NEQ 0 goto error
if not exist hugo.exe goto install
popd

REM Generate Hugo static site from source on GitHub
:build
echo Building Hugo static site...
call cd ../../../../repository
call D:\home\site\deployments\tools\hugo\bin\hugo -d D:\home\site\wwwroot 
if !ERRORLEVEL! NEQ 0 goto error

goto end

:error
echo An error has occurred during web site deployment.
call :exitSetErrorLevel
call :exitFromFunction 2>nul

:exitSetErrorLevel
exit /b 1

:exitFromFunction
()

:end
echo Hugo build finished successfully.

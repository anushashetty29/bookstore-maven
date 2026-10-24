@echo off
setlocal
rem Manual build of the bookstore WAR (no Maven).
rem Requires: JDK 11+, TOMCAT_HOME and JSTL_JAR environment variables.

echo === MANUAL BUILD STARTED: %DATE% %TIME% ===
set START_TIME=%TIME%

if "%TOMCAT_HOME%"=="" (echo ERROR: TOMCAT_HOME is not set & exit /b 1)
if "%JSTL_JAR%"=="" (echo ERROR: JSTL_JAR is not set, path to jstl-1.2.jar & exit /b 1)
if not exist "%TOMCAT_HOME%\lib\servlet-api.jar" (echo ERROR: servlet-api.jar not found in %TOMCAT_HOME%\lib & exit /b 1)
if not exist "%JSTL_JAR%" (echo ERROR: JSTL jar not found at %JSTL_JAR% & exit /b 1)

echo [1/6] Cleaning previous build...
if exist build rmdir /s /q build
if exist manual-bookstore.war del /q manual-bookstore.war

echo [2/6] Creating directory structure...
mkdir build\WEB-INF\classes
mkdir build\WEB-INF\lib

echo [3/6] Compiling Java sources with javac --release 11...
javac --release 11 -encoding UTF-8 -cp "%TOMCAT_HOME%\lib\servlet-api.jar" -d build\WEB-INF\classes src\main\java\com\bookstore\model\Book.java src\main\java\com\bookstore\model\CartItem.java src\main\java\com\bookstore\data\BookRepository.java src\main\java\com\bookstore\servlet\CatalogServlet.java src\main\java\com\bookstore\servlet\CartServlet.java src\main\java\com\bookstore\servlet\OrderServlet.java
if errorlevel 1 (echo ERROR: compilation failed & exit /b 1)

echo [4/6] Copying web resources (JSP, CSS, web.xml)...
xcopy /E /I /Y /Q src\main\webapp build >nul
if errorlevel 1 (echo ERROR: copy failed & exit /b 1)

echo [5/6] Copying JSTL library...
copy /Y "%JSTL_JAR%" build\WEB-INF\lib\ >nul
if errorlevel 1 (echo ERROR: could not copy JSTL jar & exit /b 1)

echo [6/6] Packaging WAR with the jar tool...
jar -cf manual-bookstore.war -C build .
if errorlevel 1 (echo ERROR: jar packaging failed & exit /b 1)

echo === MANUAL BUILD FINISHED: %DATE% %TIME% ===
echo Start time: %START_TIME%
echo End time:   %TIME%
echo Output: manual-bookstore.war
endlocal

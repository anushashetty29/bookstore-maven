# Online Bookstore (Maven build automation practical)

A small JSP + Servlet web app (in-memory data, no database) built two ways: manually and with Maven.

## Prerequisites
- JDK 11 or newer (`java -version`, `javac -version`)
- Apache Maven 3.6+ (`mvn -version`)
- Apache Tomcat 9 (set `TOMCAT_HOME` to its folder)
- For the manual build only: `jstl-1.2.jar` (set `JSTL_JAR` to its full path)

## Manual build (no Maven)
Set environment variables first.

Windows (cmd):
```
set TOMCAT_HOME=C:\apache-tomcat-9.0.x
set JSTL_JAR=C:\libs\jstl-1.2.jar
manual-build.bat
```
Linux / macOS:
```
export TOMCAT_HOME=/opt/apache-tomcat-9.0.x
export JSTL_JAR=/path/to/jstl-1.2.jar
./manual-build.sh
```
Steps performed: clean -> create folders -> `javac --release 11` into `build/WEB-INF/classes` (classpath `%TOMCAT_HOME%/lib/servlet-api.jar`) -> copy webapp files -> copy JSTL jar -> `jar` to `manual-bookstore.war`.

## Maven build
```
mvn clean package
```
Output: `target/bookstore.war`

## Deploy
1. Copy `target/bookstore.war` to `TOMCAT_HOME/webapps`
2. Start Tomcat (`TOMCAT_HOME/bin/startup.bat` or `startup.sh`)
3. Open http://localhost:8080/bookstore/

## Optional: deploy with Cargo
```
mvn -Pcargo cargo:run
```
Uses `TOMCAT_HOME` by default. Override with `-Dtomcat.home=/path/to/tomcat`. The default `mvn package` does not use Cargo.

## Pages
- `/catalog` list of 8 books, add to cart
- `/cart` view and remove items, checkout
- `/order` order confirmation

## Manual vs Maven

| Aspect | Manual build | Maven build |
|---|---|---|
| Steps | ~6 separate steps (clean, compile, copy files, copy lib, package) | 1 command: `mvn clean package` |
| Time | Slower by hand, needs scripts | Fast after first dependency download (cached) |
| Error risk | High: wrong classpath, missing jars, forgotten files | Low: structure and dependencies declared in `pom.xml` |
| Reproducibility | Depends on local paths and env variables | Same result on any machine with JDK + Maven |
| Dependency management | Manual jar download and copy | Automatic from Maven Central, with versions |
| Deployment | Manual copy | Manual copy or `mvn -Pcargo cargo:run` |

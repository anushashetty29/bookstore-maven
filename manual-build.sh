#!/bin/bash
# Manual build of the bookstore WAR (no Maven).
# Requires: JDK 11+, TOMCAT_HOME and JSTL_JAR environment variables.
set -e

START=$(date +%s)
echo "=== MANUAL BUILD STARTED: $(date) ==="

if [ -z "$TOMCAT_HOME" ]; then echo "ERROR: TOMCAT_HOME is not set"; exit 1; fi
if [ -z "$JSTL_JAR" ]; then echo "ERROR: JSTL_JAR is not set (path to jstl-1.2.jar)"; exit 1; fi
if [ ! -f "$TOMCAT_HOME/lib/servlet-api.jar" ]; then echo "ERROR: $TOMCAT_HOME/lib/servlet-api.jar not found"; exit 1; fi
if [ ! -f "$JSTL_JAR" ]; then echo "ERROR: JSTL jar not found at $JSTL_JAR"; exit 1; fi

echo "[1/6] Cleaning previous build..."
rm -rf build manual-bookstore.war

echo "[2/6] Creating directory structure..."
mkdir -p build/WEB-INF/classes build/WEB-INF/lib

echo "[3/6] Compiling Java sources with javac --release 11..."
javac --release 11 -encoding UTF-8 \
  -cp "$TOMCAT_HOME/lib/servlet-api.jar" \
  -d build/WEB-INF/classes \
  src/main/java/com/bookstore/model/Book.java \
  src/main/java/com/bookstore/model/CartItem.java \
  src/main/java/com/bookstore/data/BookRepository.java \
  src/main/java/com/bookstore/servlet/CatalogServlet.java \
  src/main/java/com/bookstore/servlet/CartServlet.java \
  src/main/java/com/bookstore/servlet/OrderServlet.java

echo "[4/6] Copying web resources (JSP, CSS, web.xml)..."
cp -r src/main/webapp/. build/

echo "[5/6] Copying JSTL library..."
cp "$JSTL_JAR" build/WEB-INF/lib/

echo "[6/6] Packaging WAR with the jar tool..."
jar -cf manual-bookstore.war -C build .

END=$(date +%s)
echo "=== MANUAL BUILD FINISHED: $(date) ==="
echo "Output: manual-bookstore.war"
echo "Total time: $((END - START)) seconds"

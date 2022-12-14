@rem
@rem Copyright 2015 the original author or authors.
@rem
@rem Licensed under the Apache License, Version 2.0 (the "License");
@rem you may not use this file except in compliance with the License.
@rem You may obtain a copy of the License at
@rem
@rem      https://www.apache.org/licenses/LICENSE-2.0
@rem
@rem Unless required by applicable law or agreed to in writing, software
@rem distributed under the License is distributed on an "AS IS" BASIS,
@rem WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
@rem See the License for the specific language governing permissions and
@rem limitations under the License.
@rem

@if "%DEBUG%" == "" @echo off
@rem ##########################################################################
@rem
@rem  fis-hmc-listner-api startup script for Windows
@rem
@rem ##########################################################################

@rem Set local scope for the variables with windows NT shell
if "%OS%"=="Windows_NT" setlocal

set DIRNAME=%~dp0
if "%DIRNAME%" == "" set DIRNAME=.
set APP_BASE_NAME=%~n0
set APP_HOME=%DIRNAME%..

@rem Resolve any "." and ".." in APP_HOME to make it shorter.
for %%i in ("%APP_HOME%") do set APP_HOME=%%~fi

@rem Add default JVM options here. You can also use JAVA_OPTS and FIS_HMC_LISTNER_API_OPTS to pass JVM options to this script.
set DEFAULT_JVM_OPTS=

@rem Find java.exe
if defined JAVA_HOME goto findJavaFromJavaHome

set JAVA_EXE=java.exe
%JAVA_EXE% -version >NUL 2>&1
if "%ERRORLEVEL%" == "0" goto execute

echo.
echo ERROR: JAVA_HOME is not set and no 'java' command could be found in your PATH.
echo.
echo Please set the JAVA_HOME variable in your environment to match the
echo location of your Java installation.

goto fail

:findJavaFromJavaHome
set JAVA_HOME=%JAVA_HOME:"=%
set JAVA_EXE=%JAVA_HOME%/bin/java.exe

if exist "%JAVA_EXE%" goto execute

echo.
echo ERROR: JAVA_HOME is set to an invalid directory: %JAVA_HOME%
echo.
echo Please set the JAVA_HOME variable in your environment to match the
echo location of your Java installation.

goto fail

:execute
@rem Setup the command line

set CLASSPATH=%APP_HOME%\lib\fis-hmc-listner-api-0.0.1.jar;%APP_HOME%\lib\junit-4.13.1.jar;%APP_HOME%\lib\spring-boot-starter-web-2.4.3.jar;%APP_HOME%\lib\service-auth-provider-client-4.0.0.jar;%APP_HOME%\lib\spring-boot-starter-actuator-2.4.3.jar;%APP_HOME%\lib\spring-cloud-starter-openfeign-3.0.5.jar;%APP_HOME%\lib\spring-cloud-openfeign-core-3.0.5.jar;%APP_HOME%\lib\spring-boot-starter-aop-2.4.3.jar;%APP_HOME%\lib\spring-boot-starter-json-2.4.3.jar;%APP_HOME%\lib\spring-retry-1.3.1.jar;%APP_HOME%\lib\spring-aspects-5.3.12.jar;%APP_HOME%\lib\springfox-swagger2-3.0.0.jar;%APP_HOME%\lib\logging-5.1.9.jar;%APP_HOME%\lib\logging-appinsights-5.1.9.jar;%APP_HOME%\lib\auth-checker-lib-2.1.4.jar;%APP_HOME%\lib\spring-boot-starter-security-2.4.3.jar;%APP_HOME%\lib\spring-cloud-starter-3.0.4.jar;%APP_HOME%\lib\spring-boot-starter-2.4.3.jar;%APP_HOME%\lib\spring-boot-starter-logging-2.4.3.jar;%APP_HOME%\lib\log4j-to-slf4j-2.17.1.jar;%APP_HOME%\lib\log4j-api-2.17.2.jar;%APP_HOME%\lib\azure-messaging-servicebus-7.4.2.jar;%APP_HOME%\lib\azure-core-amqp-2.3.3.jar;%APP_HOME%\lib\azure-core-http-netty-1.11.1.jar;%APP_HOME%\lib\azure-core-1.21.0.jar;%APP_HOME%\lib\azure-servicebus-3.6.5.jar;%APP_HOME%\lib\jjwt-0.9.1.jar;%APP_HOME%\lib\hamcrest-core-2.2.jar;%APP_HOME%\lib\spring-boot-starter-tomcat-2.4.3.jar;%APP_HOME%\lib\spring-webmvc-5.3.12.jar;%APP_HOME%\lib\spring-security-web-5.5.3.jar;%APP_HOME%\lib\feign-form-spring-3.8.0.jar;%APP_HOME%\lib\spring-web-5.3.12.jar;%APP_HOME%\lib\spring-boot-actuator-autoconfigure-2.4.3.jar;%APP_HOME%\lib\micrometer-core-1.6.4.jar;%APP_HOME%\lib\springfox-swagger-common-3.0.0.jar;%APP_HOME%\lib\springfox-spring-webmvc-3.0.0.jar;%APP_HOME%\lib\springfox-spring-webflux-3.0.0.jar;%APP_HOME%\lib\springfox-spring-web-3.0.0.jar;%APP_HOME%\lib\springfox-schema-3.0.0.jar;%APP_HOME%\lib\springfox-spi-3.0.0.jar;%APP_HOME%\lib\springfox-core-3.0.0.jar;%APP_HOME%\lib\spring-plugin-metadata-2.0.0.RELEASE.jar;%APP_HOME%\lib\spring-plugin-core-2.0.0.RELEASE.jar;%APP_HOME%\lib\spring-boot-autoconfigure-2.4.3.jar;%APP_HOME%\lib\spring-boot-actuator-2.4.3.jar;%APP_HOME%\lib\spring-boot-2.4.3.jar;%APP_HOME%\lib\spring-security-config-5.5.3.jar;%APP_HOME%\lib\spring-security-core-5.6.1.jar;%APP_HOME%\lib\spring-context-5.3.12.jar;%APP_HOME%\lib\spring-aop-5.3.12.jar;%APP_HOME%\lib\aspectjweaver-1.9.6.jar;%APP_HOME%\lib\jackson-datatype-jdk8-2.11.4.jar;%APP_HOME%\lib\jackson-datatype-jsr310-2.11.4.jar;%APP_HOME%\lib\jackson-module-parameter-names-2.11.4.jar;%APP_HOME%\lib\java-logging-spring-5.0.1.jar;%APP_HOME%\lib\java-logging-5.0.1.jar;%APP_HOME%\lib\logstash-logback-encoder-6.6.jar;%APP_HOME%\lib\jackson-dataformat-xml-2.11.4.jar;%APP_HOME%\lib\feign-jackson-10.12.jar;%APP_HOME%\lib\java-jwt-3.12.0.jar;%APP_HOME%\lib\jackson-module-jaxb-annotations-2.11.4.jar;%APP_HOME%\lib\azure-client-authentication-1.7.14.jar;%APP_HOME%\lib\azure-client-runtime-1.7.14.jar;%APP_HOME%\lib\client-runtime-1.7.14.jar;%APP_HOME%\lib\converter-jackson-2.6.4.jar;%APP_HOME%\lib\jackson-datatype-joda-2.11.4.jar;%APP_HOME%\lib\jackson-databind-2.11.4.jar;%APP_HOME%\lib\hibernate-validator-6.1.7.Final.jar;%APP_HOME%\lib\classmate-1.5.1.jar;%APP_HOME%\lib\swagger-models-1.5.20.jar;%APP_HOME%\lib\jul-to-slf4j-1.7.30.jar;%APP_HOME%\lib\applicationinsights-logging-logback-2.6.1.jar;%APP_HOME%\lib\logback-classic-1.2.11.jar;%APP_HOME%\lib\qpid-proton-j-extensions-1.2.4.jar;%APP_HOME%\lib\async-http-client-2.12.1.jar;%APP_HOME%\lib\async-http-client-netty-utils-2.12.1.jar;%APP_HOME%\lib\adal4j-1.6.7.jar;%APP_HOME%\lib\feign-slf4j-10.12.jar;%APP_HOME%\lib\feign-form-3.8.0.jar;%APP_HOME%\lib\slf4j-api-1.7.30.jar;%APP_HOME%\lib\swagger-annotations-1.5.20.jar;%APP_HOME%\lib\mapstruct-1.3.1.Final.jar;%APP_HOME%\lib\javax.servlet-api-4.0.1.jar;%APP_HOME%\lib\applicationinsights-spring-boot-starter-2.6.1.jar;%APP_HOME%\lib\jackson-annotations-2.11.4.jar;%APP_HOME%\lib\jackson-core-2.11.4.jar;%APP_HOME%\lib\reactor-netty-http-1.0.4.jar;%APP_HOME%\lib\reactor-netty-core-1.0.4.jar;%APP_HOME%\lib\reactor-core-3.4.3.jar;%APP_HOME%\lib\netty-tcnative-boringssl-static-2.0.36.Final.jar;%APP_HOME%\lib\proton-j-0.33.8.jar;%APP_HOME%\lib\googleauth-1.5.0.jar;%APP_HOME%\lib\httpclient-4.5.13.jar;%APP_HOME%\lib\guava-31.0.1-jre.jar;%APP_HOME%\lib\lombok-1.18.18.jar;%APP_HOME%\lib\hamcrest-2.2.jar;%APP_HOME%\lib\jakarta.annotation-api-1.3.5.jar;%APP_HOME%\lib\spring-beans-5.3.12.jar;%APP_HOME%\lib\spring-expression-5.3.12.jar;%APP_HOME%\lib\spring-core-5.3.12.jar;%APP_HOME%\lib\snakeyaml-1.27.jar;%APP_HOME%\lib\tomcat-embed-websocket-9.0.64.jar;%APP_HOME%\lib\tomcat-embed-core-9.0.64.jar;%APP_HOME%\lib\jakarta.el-4.0.2.jar;%APP_HOME%\lib\HdrHistogram-2.1.12.jar;%APP_HOME%\lib\LatencyUtils-2.0.3.jar;%APP_HOME%\lib\jakarta.validation-api-2.0.2.jar;%APP_HOME%\lib\jboss-logging-3.4.1.Final.jar;%APP_HOME%\lib\swagger-annotations-2.1.2.jar;%APP_HOME%\lib\classgraph-4.8.83.jar;%APP_HOME%\lib\logback-core-1.2.11.jar;%APP_HOME%\lib\applicationinsights-core-2.6.1.jar;%APP_HOME%\lib\applicationinsights-web-2.6.1.jar;%APP_HOME%\lib\woodstox-core-6.2.3.jar;%APP_HOME%\lib\stax2-api-4.2.1.jar;%APP_HOME%\lib\netty-reactive-streams-2.0.4.jar;%APP_HOME%\lib\reactive-streams-1.0.3.jar;%APP_HOME%\lib\netty-handler-proxy-4.1.78.Final.jar;%APP_HOME%\lib\netty-codec-http2-4.1.78.Final.jar;%APP_HOME%\lib\netty-codec-http-4.1.78.Final.jar;%APP_HOME%\lib\netty-resolver-dns-native-macos-4.1.78.Final-osx-x86_64.jar;%APP_HOME%\lib\netty-resolver-dns-classes-macos-4.1.78.Final.jar;%APP_HOME%\lib\netty-resolver-dns-4.1.78.Final.jar;%APP_HOME%\lib\netty-handler-4.1.78.Final.jar;%APP_HOME%\lib\netty-transport-native-epoll-4.1.78.Final-linux-x86_64.jar;%APP_HOME%\lib\netty-transport-native-kqueue-4.1.78.Final-osx-x86_64.jar;%APP_HOME%\lib\netty-transport-classes-epoll-4.1.78.Final.jar;%APP_HOME%\lib\netty-transport-classes-kqueue-4.1.78.Final.jar;%APP_HOME%\lib\netty-transport-native-unix-common-4.1.78.Final.jar;%APP_HOME%\lib\netty-codec-socks-4.1.78.Final.jar;%APP_HOME%\lib\netty-codec-dns-4.1.78.Final.jar;%APP_HOME%\lib\netty-codec-4.1.78.Final.jar;%APP_HOME%\lib\netty-transport-4.1.78.Final.jar;%APP_HOME%\lib\netty-buffer-4.1.78.Final.jar;%APP_HOME%\lib\javax.activation-1.2.0.jar;%APP_HOME%\lib\commons-codec-1.15.jar;%APP_HOME%\lib\azure-annotations-1.10.0.jar;%APP_HOME%\lib\httpcore-4.4.14.jar;%APP_HOME%\lib\failureaccess-1.0.1.jar;%APP_HOME%\lib\listenablefuture-9999.0-empty-to-avoid-conflict-with-guava.jar;%APP_HOME%\lib\jsr305-3.0.2.jar;%APP_HOME%\lib\checker-qual-3.12.0.jar;%APP_HOME%\lib\error_prone_annotations-2.7.1.jar;%APP_HOME%\lib\j2objc-annotations-1.3.jar;%APP_HOME%\lib\spring-cloud-commons-3.0.4.jar;%APP_HOME%\lib\feign-core-10.12.jar;%APP_HOME%\lib\spring-jcl-5.3.12.jar;%APP_HOME%\lib\jakarta.el-api-4.0.0.jar;%APP_HOME%\lib\byte-buddy-1.10.20.jar;%APP_HOME%\lib\jakarta.xml.bind-api-2.3.3.jar;%APP_HOME%\lib\jakarta.activation-api-1.2.2.jar;%APP_HOME%\lib\netty-resolver-4.1.78.Final.jar;%APP_HOME%\lib\netty-common-4.1.78.Final.jar;%APP_HOME%\lib\oauth2-oidc-sdk-8.36.jar;%APP_HOME%\lib\gson-2.8.9.jar;%APP_HOME%\lib\commons-lang3-3.11.jar;%APP_HOME%\lib\spring-cloud-context-3.0.4.jar;%APP_HOME%\lib\spring-security-rsa-1.0.10.RELEASE.jar;%APP_HOME%\lib\spring-security-crypto-5.5.3.jar;%APP_HOME%\lib\adapter-rxjava-2.6.4.jar;%APP_HOME%\lib\retrofit-2.6.4.jar;%APP_HOME%\lib\logging-interceptor-3.14.9.jar;%APP_HOME%\lib\okhttp-urlconnection-3.14.9.jar;%APP_HOME%\lib\okhttp-3.14.9.jar;%APP_HOME%\lib\rxjava-1.3.8.jar;%APP_HOME%\lib\nimbus-jose-jwt-8.20.2.jar;%APP_HOME%\lib\jcip-annotations-1.0-1.jar;%APP_HOME%\lib\content-type-2.1.jar;%APP_HOME%\lib\json-smart-2.4.7.jar;%APP_HOME%\lib\lang-tag-1.4.4.jar;%APP_HOME%\lib\bcpkix-jdk15on-1.68.jar;%APP_HOME%\lib\commons-fileupload-1.4.jar;%APP_HOME%\lib\okio-1.17.2.jar;%APP_HOME%\lib\joda-time-2.9.9.jar;%APP_HOME%\lib\accessors-smart-2.4.7.jar;%APP_HOME%\lib\bcprov-jdk15on-1.69.jar;%APP_HOME%\lib\commons-io-2.11.0.jar;%APP_HOME%\lib\asm-9.1.jar


@rem Execute fis-hmc-listner-api
"%JAVA_EXE%" %DEFAULT_JVM_OPTS% %JAVA_OPTS% %FIS_HMC_LISTNER_API_OPTS%  -classpath "%CLASSPATH%" uk.gov.hmcts.reform.PrlUpdateApplication %*

:end
@rem End local scope for the variables with windows NT shell
if "%ERRORLEVEL%"=="0" goto mainEnd

:fail
rem Set variable FIS_HMC_LISTNER_API_EXIT_CONSOLE if you need the _script_ return code instead of
rem the _cmd.exe /c_ return code!
if  not "" == "%FIS_HMC_LISTNER_API_EXIT_CONSOLE%" exit 1
exit /b 1

:mainEnd
if "%OS%"=="Windows_NT" endlocal

:omega

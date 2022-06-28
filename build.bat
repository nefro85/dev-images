@echo off

SET ARGS=%2 %3 %4

IF "%1"=="jdk11" goto jdk11

goto exit-noop

:jdk11
docker build -t s7i/jdk11 -f Dockerfile.jdk11-4dev .
goto bye

@rem nice bye bye
:bye

echo DONE / bye bye
exit 0

:exit-noop
echo BAD CALL
exit -3

@echo off
REM Script to build and run the Salary API Docker container

set IMAGE_NAME=salary-api
set CONTAINER_PORT=8089
set HOST_PORT=8088

echo Building Docker image: %IMAGE_NAME%
docker build -t %IMAGE_NAME% .

if %errorlevel% equ 0 (
    echo Build successful. Running container on host port %HOST_PORT%...
    docker run -p %HOST_PORT%:%CONTAINER_PORT% %IMAGE_NAME%
) else (
    echo Build failed. Please check the Dockerfile and try again.
    exit /b 1
)

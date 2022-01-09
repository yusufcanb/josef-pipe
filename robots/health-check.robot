*** Settings ***
Library                 Process
Documentation           Health Check Tasks

*** Tasks ***

Health Check
    ${result} =	        Run Process  curl -v https://postman-echo.com/get  shell=True  stderr=STDOUT
    Log                 ${result.stdout}


*** Settings ***
Library                 Process
Documentation           API Watchdog

*** Tasks ***

Check Environment
    ${result} =	        Run Process  curl -v https://postman-echo.com/get  shell=True  stderr=STDOUT
    Log                 ${result.stdout}
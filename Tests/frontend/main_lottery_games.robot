*** Settings ***
Library     SeleniumLibrary
Library     ../../utils/python/webdriver_management.py

*** Test Cases ***
Initial Test
    Open Browser and Install Web Driver      172.16.12.155     chrome

*** Keywords ***
Open Browser and Install Web Driver
    #Used to properly configure headless mode. Chrome is the default headless browser.
    [arguments]             ${ip}              ${browser}
    ${browser}   ${webdriver}=        get_webdriver     ${browser}
    ${webdriver_path}=   Evaluate      $webdriver.install()
    Log To Console    ${webdriver_path}
    IF  'headless'=='${browser}'
    #utilizado para rodar testes frontend dentro de containers
        ${chrome_options}=     Evaluate    sys.modules['selenium.webdriver'].ChromeOptions()    sys, selenium.webdriver
        Call Method    ${chrome_options}   add_argument    headless
        Call Method    ${chrome_options}   add_argument    no-sandbox
        Call Method    ${chrome_options}   add_argument    disable-dev-shm-usage
        Call Method    ${chrome_options}   add_argument    window-size\=1920,1080
        Call Method    ${chrome_options}   add_argument    log-level\=3
        ${options}=     Call Method     ${chrome_options}    to_capabilities
        SeleniumLibrary.Open Browser  ${ip}   browser=chrome  desired_capabilities=${options}   executable_path=${webdriver_path}
    ELSE
        SeleniumLibrary.Open Browser  ${ip}    ${browser}   executable_path=${webdriver_path}
    END
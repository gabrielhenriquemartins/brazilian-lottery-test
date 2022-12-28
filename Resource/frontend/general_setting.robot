*** Settings ***
Library     SeleniumLibrary
Library     ../../utils/python/webdriver_management.py
Resource    ../../Variables/all_variables.robot


*** Keywords ***
#### General Keywords
Install Web Driver and Open Browser
    #Used to properly configure headless mode. Chrome is the default headless browser.
    [arguments]             ${ip}              ${browser}
    Register Keyword To Run On Failure       NONE
    ${browser}   ${webdriver}=        get_webdriver     ${browser}
    ${webdriver_path}=   Evaluate      $webdriver.install()
    Log To Console    ${webdriver_path}
    Open Browser      ${ip}    ${browser}   executable_path=${webdriver_path}
    Maximize Browser Window

Close Session
    Close Browser

Get Current Day
    Write on Search Field    Current Day
    ${current_day}    Get Text      ${current_day_field}
    Return From Keyword      ${current_day}

Get Current Time
    Write on Search Field    Current Time
    ${current_time}    Get Text     ${current_time_field}
    Return From Keyword      ${current_time}

Write on Search Field
    [Arguments]    ${input_text}
    Run Keyword And Ignore Error    ${clean_input_search}
    Wait and Click Element          ${tf_input_search}
    Input Text    ${tf_input_search}    ${input_text}
    Press Enter

#### Generic Keywords
Wait and Click Element
    [Arguments]    ${button}
    Sleep   500ms
    Wait Until Element Is Visible    ${button}
    Click Element    ${button}

Press Enter
    press keys       none    ENTER
*** Settings ***
Library     SeleniumLibrary
Library     String
Library     ../../utils/python/webdriver_management.py
Library    Collections
Resource    ../../Resource/frontend/general_setting.robot
Resource    ../../Variables/all_variables.robot

Suite Setup       Install Web Driver and Open Browser      http://google.com     chrome

#Suite Teardown    Close Session

*** Test Cases ***
Test Case 1: Get Current Day on Google
    ${current_day}     Get Current Day
    Log To Console     Today is ${current_day}!
    ${current_time}    Get Current Time
    Log To Console     Now is ${current_time}!

Test Case 2: Compare Google Results For Mega Sena on Loteria Federal
    Check Results    lottery=Mega Sena

Test Case 3: Compare Google Results For Lotofácil on Loteria Federal
    Check Results    lottery=Lotofácil

Test Case 4: Compare Google Results For Quina on Loteria Federal
    Check Results    lottery=Quina

Test Case 5: Compare Google Results For Timemania on Loteria Federal
    Check Results    lottery=Timemania

Test Case 6: Compare Google Results For Dupla Sena on Loteria Federal
    Check Results    lottery=Dupla Sena

Test Case 7: Compare Google Results For Lotomania on Loteria Federal
    Check Results    lottery=Lotomania

*** Keywords ***
Check Results
    [Arguments]    ${lottery}
    Write on Search Field   ${lottery}
    ${google_results}    Get Lottery Results on Google
    Compare Google Results With Loterica Federal     ${google_results}


Compare Google Results With Loterica Federal
    [Arguments]    ${google_results}
    Log To Console    Checking on Brazilian Oficial Web site, The Last Result: ${google_results}

Get Lottery Results on Google
    ${number_of_elements}    Get Element Count    ${google_result_holder}
    @{google_results}        Google Results       ${number_of_elements}
    Return From Keyword      ${google_results}

Google Results
    [Arguments]   ${iterations}
    FOR    ${counter}    IN RANGE    1    ${iterations+1}
        IF  '${counter}'=='1'
            ${number}     Get Text     (${google_result_holder})[${counter}]
            ${results}    Create List    ${number}
        ELSE
            ${number}     Get Text    (${google_result_holder})[${counter}]
            Append To List     ${results}    ${number}
        END
    END
    Return From Keyword    ${results}


*** Settings ***
Library     SeleniumLibrary
Library     ../../utils/python/webdriver_management.py
Library     String
Resource    ../../Resource/frontend/general_setting.robot
Resource    ../../Variables/all_variables.robot


Suite Setup       Install Web Driver and Open Browser      http://google.com     chrome


Suite Teardown    Close Session



*** Test Cases ***
Test Case 1: Get Current Day
    ${current_day}     Get Current Day
    Log To Console     Today is ${current_day}!
    ${current_time}    Get Current Time
    Log To Console     Now is ${current_time}!
    ${index}   Get String Position in a Array   @{day_of_the_week}   string=${current_day}
    Write on Search Field   ${lottery_games}[${index}] last result


*** Keywords ***
Get String Position in a Array
    [Arguments]    @{array}    ${string}
    ${length}   Get Length     ${array}
    FOR    ${counter}    IN RANGE    0    ${length}
        IF  '${array}[${counter}]'=='${string}'
            Return From Keyword    ${counter}
            Exit For Loop
        END
    END
*** Settings ***
Library     SeleniumLibrary
Library     String
Library     DateTime
Library     OperatingSystem
Library     ../../utils/python/webdriver_management.py
Library     Collections
Resource    ../../Resource/frontend/general_setting.robot
Resource    ../../Variables/all_variables.robot

Suite Setup       Run Keywords     Install Web Driver and Open Browser      http://google.com     chrome
...               AND              Screenshot Path

Test Teardown       Run Keywords    Run Keyword If Test Failed           Screenshot Failed tests     ${test_name}
...                 AND     Run Keyword If Test Passed           Capture Page Screenshot Successfull Test     ${test_name}

#Suite Teardown    Close Session

*** Test Cases ***
Test Case 1: Get Current Day on Google
    Set Global Variable   ${test_name}    Get Current Day on Google
    ${current_day}     Get Current Day
    Log To Console     Today is ${current_day}!
    ${current_time}    Get Current Time
    Log To Console     Now is ${current_time}!

Test Case 2: Compare Google Results For Mega Sena on Loteria Federal
    Set Global Variable   ${test_name}    Mega Sena on Loteria Federal
    Check Results    lottery=Mega Sena

Test Case 3: Compare Google Results For Lotofácil on Loteria Federal
    Set Global Variable   ${test_name}    Lotofácil on Loteria Federal
    Check Results    lottery=Lotofacil

Test Case 4: Compare Google Results For Quina on Loteria Federal
    Set Global Variable   ${test_name}    Quina on Loteria Federal
    Check Results    lottery=Quina

Test Case 5: Compare Google Results For Timemania on Loteria Federal
    Set Global Variable   ${test_name}    Timemania on Loteria Federal
    Check Results    lottery=Timemania

Test Case 6: Compare Google Results For Dupla Sena on Loteria Federal
    Set Global Variable   ${test_name}    Dupla Sena on Loteria Federal
    Check Results    lottery=Dupla Sena

Test Case 7: Compare Google Results For Lotomania on Loteria Federal
    Set Global Variable   ${test_name}    Lotomania on Loteria Federal
    Check Results    lottery=Lotomania

*** Keywords ***
Check Results
    [Arguments]    ${lottery}
    Go To    http://google.com
    Write on Search Field   ${lottery}
    ${google_results}    Get Lottery Results on Google
    Compare Google Results With Loterica Federal     ${lottery}    ${google_results}

Compare Google Results With Loterica Federal
    [Arguments]    ${lottery}   ${google_results}
    Log To Console    Checking on Brazilian Oficial Web site, The ${lottery} Last Result: ${google_results}
    ${lottery_title_case}     Convert To Title Case    ${lottery}
    ${formated_lottery}   Replace String    string=${lottery_title_case}     search_for=${SPACE}    replace_with=-
    Go to    https://loterias.caixa.gov.br/
    ${number_of_elements}    Get Length    ${google_results}
    Run keyword and ignore error   Wait And Click Element    //*[@id="adopt-accept-all-button"]    timeout=3
    Wait And Click Element    //*[@class="see-more"]//*[@href="/Paginas/${formated_lottery}.aspx"]
    FOR  ${element}   IN RANGE   0    ${number_of_elements}
        Wait Until Page Contains Element     ${loteria_federal_holder}\[contains(text(),'${google_results}[${element}]')]
    END
    Scroll Element Into View    //*[contains(text(),'Arrecadação total')]
    Sleep   5

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


Capture Page Screenshot Successfull Test
	[Arguments]    ${name}
	Sleep    1
	Capture Page Screenshot     ${name}.png

Screenshot Failed tests
    [Arguments]                 ${test_name}     ${path}=./results/logs
	IF  '${path}'!='./results/logs'
		Set Screenshot Directory    ${path}/Fail
		Wait and Capture Screenshot    ${test_name}
	ELSE
	    Set Screenshot Directory    ${path}/${date}/Fail/
		Wait and Capture Screenshot    ${test_name}
		Set Screenshot Directory    ./results/logs/${date}/Pass/
	END

Screenshot Path
    ${full_date}     Get Current Date
    ${date}          Convert Date            ${full_date}              result_format=%d-%m-%Y
    Set Global Variable    ${date}    ${date}
    Create File                 ./results/logs/${date}/empty.txt
    Empty Directory             ./results/logs/${date}/
    Create File                 ./results/logs/${date}/Pass/readme.txt
    Append To File              ./results/logs/${date}/Pass/readme.txt    This folder contains all tests that PASSED during the execution started on ${full_date}
    Create File                 ./results/logs/${date}/Fail/readme.txt
    Append To File              ./results/logs/${date}/Fail/readme.txt    This folder contains all tests that FAILED during the execution started on ${full_date}
    Create File                 ./results/logs/${date}/Reports/readme.txt
    Append To File              ./results/logs/${date}/Fail/readme.txt    This folder contains all reports that where download during the execution started on ${full_date}
    Set Screenshot Directory    ./results/logs/${date}/Pass/

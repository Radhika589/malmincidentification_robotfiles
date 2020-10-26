*** Settings ***
Library        DateTime
Library        String
Resource       ../Resources/keywords.robot
Library        SeleniumLibrary

Suite Setup       Begin Web Test
Suite Teardown    End Web Test

*** Variables ***

${url}         http://127.0.0.1:8080/
${browser}     chrome

*** Test Cases ***

Sign Out
    [Documentation]             Test for Sign Out
    [Tags]                      TC_10
    Click Sign Out

Try Edit After Sign Out
    [Documentation]             Test for Try Edit After Sign Out
    [Tags]                      TC_11
    Click Manage Option After Sign Out

Sign In with Edited Password
    [Documentation]             Test for Sign In with Edited Password
    [Tags]                      TC_12
    Click Sign In With Edited Password
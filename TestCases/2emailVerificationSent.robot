*** Settings ***
Resource       ../Resources/keywords.robot
Library        SeleniumLibrary
Library        ImapLibrary
Suite Setup    Begin Web Test
Suite Teardown  End Web Test

*** Variables ***

${url}            http://127.0.0.1:8080/
${browser}        chrome

*** Test Cases ***

Email Verification
    [Documentation]             Test for email verification
    [Tags]                      Email_Verification_TC_2
    Check Email Verification Sent
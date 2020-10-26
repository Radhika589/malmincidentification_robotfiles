*** Settings ***
Resource       ../Resources/keywords.robot
Library        SeleniumLibrary
Library        ImapLibrary
Library        Collections
Library        String
Library        re
Suite Setup    Begin Web Test
Suite Teardown  End Web Test

*** Variables ***

${url}            http://127.0.0.1:8080/
${browser}        chrome

*** Test Cases ***

Click Email Link And Activate The Account
    [Documentation]             Test for activation link in email body
    [Tags]                      Email_Link_TC_4
    Mazimize the Browser Window
    Activate Account With Invalid Verification Code
    Activate Account With valid Verification Code
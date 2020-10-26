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
Activation Link For Reset Password
    [Documentation]             Test for reseting the password
    [Tags]                      TC_5
    Set Selenium Speed            300ms
    Verify Home Page
    Restore Email Page Validation
    Check Password Activation Link Sent To The Mail
    Go To Reset Password Page using Activation Link From Mail
    Restore Password Validation




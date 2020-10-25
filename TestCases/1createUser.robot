*** Settings ***

Library           SeleniumLibrary
Library           DateTime
Library           String
Resource          ../Resources/keywords.robot
Suite Setup       Begin Web Test
Suite Teardown    End Web Test

*** Variables ***

${url}            http://127.0.0.1:8080/
${browser}        chrome

*** Test Cases ***

Create User
    [Documentation]             Test for user registration
    [Tags]                      Register_TC 1
    Create User Empty Email and Password
    Create User Only Characters in Email
    Create User Only Numbers in Email
    Create User Wrong Password
    Create User Valid Email and Password








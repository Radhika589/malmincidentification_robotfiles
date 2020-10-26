*** Settings ***
Library        DateTime
Library        String
Resource       ../Resources/keywords.robot
Library        SeleniumLibrary

Suite Setup       Begin Web Test
Suite Teardown    End Web Test

*** Variables ***

${url}            http://127.0.0.1:8080/
${browser}        chrome

*** Test Cases ***

SignIn Malminc Before Activating Account
    [Documentation]             Test for valid SignIN After Registering
    [Tags]                      SignInBeforeActivating_TC_3
    SignIn Malminc With Valid Credentials Before Activating Account

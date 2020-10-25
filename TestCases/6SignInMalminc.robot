*** Settings ***
Library        DateTime
Library        String
Resource       ../Resources/keywords.robot
Library        SeleniumLibrary

Suite Setup       Begin Web Test
#Suite Teardown    End Web Test

*** Variables ***

${url}         http://127.0.0.1:8080/
${browser}     chrome

*** Test Cases ***

SignIn Malminc After Activating Account
    [Documentation]             Test for valid SignIN After Registering
    [Tags]                      SignInAfterActivating_TC
    #SignIn Malminc With Invalid Credentials
    #SignIn Malminc With Empty Email
    SignIn Malminc With Valid Credentials

Edit Username
    [Documentation]             Test for Edit Username
    [Tags]                      TC_6
   # SignIn Malminc With Valid Credential
    Edit Username Only Numbers
    Edit Username Only SpecialCharacters
    Edit Username Empty
    Edit Username Valid

Edit Mail
    [Documentation]             Test for Edit Mail
    [Tags]                      TC_7
    Edit Email Only Numbers
    Edit Mail Only SpecialCharacters
    Edit Mail Empty
    Edit Mail Valid

Edit Password
    [Documentation]             Test for Edit Mail
    [Tags]                      TC_8
    Edit Password Invalid Length
    Edit Password Empty
    Edit Password Valid

Sign Out
    [Documentation]             Test for Sign Out
    [Tags]                      TC_9
    Click Sign Out






*** Settings ***
Library        re

*** Keywords ***

#TC1
Begin Web Test
   Open Browser                   about:blank     ${BROWSER}

Go to Web Page
   Load Page
   Mazimize the Browser Window

Load Page
   Go To                          ${URL}

Mazimize the Browser Window
   Maximize Browser Window

Verify Home Page
   Go to Web Page
   Load Page
   Element Should be Visible       xpath:/html/body/nav/div/div[2]/img
   sleep                           2s

Click Menu
   Click Element                   xpath:/html/body/nav/div/div[3]/img

Create User Empty Email and Password
   Verify Home Page
   Click Menu
   Wait Until Element Is Visible   xpath://*[@id="myNav"]/div/a[2]
   Click Link                      xpath://*[@id="myNav"]/div/a[2]
   Execute Javascript              window.scrollTo(0,400)
   Click button                    id:submit
   ${createpagetext}               Get Text             xpath:/html/body/div[4]/form/p[1]/label
   Should be Equal                 ${createpagetext}    Create your identification here

Create User Only Characters in Email
   sleep                           2s
   Input Text                      name:username        malminc
   Input Text                      name:password        111111
   Wait Until Element Is Visible   id:submit
   Click Button                    id:submit
   Page Should Contain             Email is not in the email format
   sleep                           2s

Create User Wrong Password
   Input Text                      name:username    bluestars0987@gmail.com
   Input Text                      name:password    11111
   Click Button                    id:submit
   Page Should Contain             Password must have at least 6 characters
   sleep                           2s

Create User Only Numbers in Email
   Input Text                      name:username    1111112222223
   Input Text                      name:password    111111
   Click Button                    id:submit
   Page Should Contain             Email is not in the email format
   sleep                           2s

Create User Valid Email and Password
   Input Text                      name:username    bluestars0987@gmail.com
   Input Text                      name:password    123456
   Click Button                    id:submit
   Page Should Contain             A verification email has been sent to bluestars0987@gmail.com. Please check your email and activate.

Get Email Body Content
    Open Mailbox    host=imap.gmail.com    user=bluestars0987@gmail.com         password=hozvfdxqgxaagjfj
    ${LATEST} =     Wait For Email         sender=chinni31.ammulu03@gmail.com    timeout=300
    ${Body} =       Get Email Body         ${LATEST}
    set suite variable                     ${Body}

Check Email Verification Sent
    Get Email Body Content
    ${BodyContent} =      Get Variable Value    ${Body}
    Should Contain        ${BodyContent}        Your verification code is
    Close Mailbox

Check Password Activation Link Sent To The Mail
    Get Email Body Content
    ${BodyContent} =      Get Variable Value    ${Body}
    Log to Console        ${BodyContent}
    Should Contain        ${BodyContent}         Please click the link below to restore your identification
    Close Mailbox

SignIn Malminc With Valid Credentials Before Activating Account
    SignIn Malminc
    sleep                           2s
    Input Text      name:email      bluestars0987@gmail.com
    Input Text      name:password   123456
    Click Button    name:submit
    Execute Javascript              window.scrollTo(0,400)
    Location Should Be              http://127.0.0.1:8080/login
    Page Should Contain             Activate your identification here

Get Activation Link And Verification Code From Email Body
    Get Email Body Content
    ${BodyContent} =        Get Variable Value             ${Body}
    ${ActivationLink} =     Get Lines Matching Regexp      ${BodyContent}       localhost/activate        partial_match=True
    ${VCodeLine} =          Get Line                       ${BodyContent}       2
    ${VCode} =              Fetch From Right	           ${VCodeLine}         ${SPACE}
    set suite variable      ${ActivationLink}
    set suite variable      ${VCode}

Get Activation Link For Reset Password From Email Body
    Get Email Body Content
    ${BodyContent} =        Get Variable Value             ${Body}
    ${ActivationLinkResetPwd} =     Get Lines Matching Regexp      ${BodyContent}       localhost/newPassword        partial_match=True
    set suite variable      ${ActivationLinkResetPwd}

Go To Reset Password Page using Activation Link From Mail
    Get Activation Link For Reset Password From Email Body
    ${ResetPasswordlink} =       Get Variable Value  ${ActivationLinkResetPwd}
    Go To                   ${ResetPasswordlink}
    Execute Javascript            window.scrollTo(0,400)

Activate Account With Invalid Verification Code
    Get Activation Link And Verification Code From Email Body
    ${link} =       Get Variable Value  ${ActivationLink}
    Go To           ${link}
    Page Should Contain     Activate your identification in one place
    Input Text              name:activationCode         sdgdgfdgfdg324sdfdsf
    Click Button            name:submit
    Page Should Contain     Enter proper verification code.
    Close Mailbox

Activate Account With valid Verification Code
    Get Activation Link And Verification Code From Email Body
    ${link} =                   Get Variable Value      ${ActivationLink}
    ${VerificationCode} =       Get Variable Value      ${VCode}
    log to console              ${VerificationCode}
    Go To                       ${link}
    Page Should Contain         Activate your identification in one place
    Input Text                  name:activationCode     ${VerificationCode}
    Click Button                name:submit
    Page Should Contain         Your email is valid, thanks!. You may now login
    Close Mailbox

SignIn Malminc
    Verify Home Page
    Click Menu
    Wait Until Element Is Visible   xpath://*[@id="myNav"]/div/a[1]
    Click Link                      xpath://*[@id="myNav"]/div/a[1]

SignIn Malminc With Invalid Credentials
    SignIn Malminc
    sleep                           2s
    Input Text      name:email      rajni.lek@gmail.com
    Input Text      name:password   12345
    Click Button    name:submit
    Execute Javascript              window.scrollTo(0,400)
    Page Should Contain             Please enter the correct email and password

SignIn Malminc With Empty Email
    SignIn Malminc
    sleep                           2s
    Input Text      name:password   123453
    Click Button    name:submit
    Execute Javascript              window.scrollTo(0,400)
    #Page Should Contain             Please fill in this field.
    Wait Until Element Is Visible       css:.required:invalid

SignIn Malminc With Valid Credentials
    SignIn Malminc
    sleep                           2s
    Input Text      name:email      bluestars0987@gmail.com
    Input Text      name:password   1234567
    Click Button    name:submit
   # Execute Javascript              window.scrollTo(0,400)
    #Page Should Contain             Please enter the correct email and password
    # Click Menu

Verify Manage/overview Page
    Page Should Contain             Welcome!

Edit Username Only Numbers
    Sleep            2s
   # Click Link                      xpath://*[@id="myNav"]/div/a[3]
    Verify Manage/overview Page
    Sleep             2s
    Click Element                   xpath:/html/body/div[4]/div/button[1]
    Execute Javascript              window.scrollTo(0,400)
    Sleep                           2s
    #Input Text                      xpath:/html/body/div[4]/form/input[1]         123456
    Input Text      name:name       1234567
    Click Button    name:submit
    #Click Button                    xpath:/html/body/div[4]/form/input[2]
    Page Should Contain             Name must contain only letters a-z
    Sleep                           2s

Edit Username Only SpecialCharacters
    Input text      name:name      "#!"#¤¤%&/(
    Click Button    name:submit
    Page Should Contain             Name must contain only letters a-z
    Sleep                           2s

Edit Username Empty
    Click Button    name:submit
    Page Should Contain             Name is required
    Sleep                           2s

Edit Username Valid
    Input text      name:name   Testers
    Click Button    name:submit
    Element Should be Visible       xpath:/html/body/nav/div/div[2]/img
    Sleep           2s

Edit Email Only Numbers
   # Verify Home Page
    Click Menu
    Sleep            2s
    Click Link                      xpath://*[@id="myNav"]/div/a[3]
    Sleep            2s
    Click Element                   xpath:/html/body/div[4]/div/button[2]
    Execute Javascript              window.scrollTo(0,400)
    Sleep            2s
    Input Text      name:email      1234567
    Click Button    name:submit
    #Click Button                    xpath:/html/body/div[4]/form/input[2]
    Page Should Contain             Email is not a valid email address
    Sleep                           2s

Edit Mail Only SpecialCharacters
    Input text      name:email     "#!"#¤¤%&/(
    Click Button    name:submit
    Page Should Contain             Email is not a valid email address
    Sleep                           2s

Edit Mail Empty
    Click Button    name:submit
    Page Should Contain             Email is required
    Sleep                           2s

Edit Mail Valid
    Input text      name:email      pinkstars0987@gmail.com
    Click Button    name:submit
    Element Should be Visible       xpath:/html/body/nav/div/div[2]/img
    Sleep           2s

Edit Password Invalid Length
   # Verify Home Page
    Click Menu
    Sleep            2s
    Click Link                      xpath://*[@id="myNav"]/div/a[3]
    Sleep            2s
    Click Element                   xpath:/html/body/div[4]/div/button[3]
    Execute Javascript              window.scrollTo(0,400)
    Sleep            2s
    Input Text      name:password      1234
    Click Button    name:submit
    #Click Button                    xpath:/html/body/div[4]/form/input[2]
    Page Should Contain             Password must be at least 6 characters long
    Sleep                           2s

Edit Password Empty
    Click Button    name:submit
    Page Should Contain             Password is required
    Sleep                           2s

Edit Password Valid
    Input text      name:password   password
    Click Button    name:submit
    Element Should be Visible       xpath:/html/body/nav/div/div[2]/img

Restore Email Page Validation
   Restore Email Page Only Numbers
   Restore Email Page Only Characters
   Restore Email Page Empty
   Restore Email Page Valid Email

Restore Email Page Only Numbers
    Click Menu
    Sleep            2s
    Click Element                   xpath://*[@id="myNav"]/div/a[4]
    Page Should Contain             Restore your identification in one place.
    Sleep            2s
    Input Text       name:email     1234567
    Click Button     name:submit
    Sleep            2s
    Page Should Contain             Email is not a valid email address

Restore Email Page Only Characters
    Sleep            2s
    Input Text       name:email     abcdefgh
    Click Button     name:submit
    Sleep            2s
    Page Should Contain             Email is not a valid email address

Restore Email Page Empty
    Sleep            2s
    Click Button     name:submit
    Page Should Contain             Email is required

Restore Email Page Valid Email
    Sleep            2s
    Input Text       name:email     bluestars0987@gmail.com
    Click Button     name:submit
    Page Should Contain             A activation link has been sent to bluestars0987@gmail.com, Click on the link to create your new passoword

Restore Password Validation
    Restore Password Not Same with New Password
    Restore Password And New Password Empty
    Restore Password And New Password Not 6 Characters
    Restore Password And New Password Valid

Restore Password Not Same with New Password
   Input Text        name:password    123
   Input Text        name:repeatPassword    1234
   Click Button      name:submit
   Page Should Contain              Password must be the same as 'repeatPassword'
   Sleep             2s

Restore Password And New Password Empty
   Click Button      name:submit
   Page Should Contain              Password is required
   Sleep             2s

Restore Password And New Password Not 6 Characters
   Input Text        name:password    1234
   Input Text        name:repeatPassword    1234
   Click Button      name:submit
   Page Should Contain             Password must be at least 6 characters long
   Sleep             2s

Restore Password And New Password Valid
   Input Text        name:password    1234567
   Input Text        name:repeatPassword    1234567
   Click Button      name:submit
   Sleep             2s

Click Sign Out
   Verify Home Page
   Click Menu
   Sleep            2s
   Click Element    xpath://*[@id="myNav"]/div/form/button

Click Manage Option After Sign Out
   Sleep            2s
   Click Menu
   Sleep            2s
   Click Element    xpath://*[@id="myNav"]/div/a[3]
   Page Should Contain     We let new customers experience your company and bring marketing to new levels.

Click Sign In With Edited Password
   Sleep            2s
   Click Menu
   Sleep            2s
   Click Element    xpath://*[@id="myNav"]/div/a[1]
   Sleep            2s
   Input Text      name:email      pinkstars0987@gmail.com
   Input Text      name:password   password
   Click Button    name:submit
   Verify Manage/overview Page

End Web Test
   Close Browser
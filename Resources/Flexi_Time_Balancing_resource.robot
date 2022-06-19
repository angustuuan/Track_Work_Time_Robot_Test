*** Settings ***
Library    AppiumLibrary

*** Variables ***
${OPTIONS_VIEW}    //android.widget.CheckedTextView[@text='Options']
${Flexi_Time_Target}    //android.widget.TextView[@text='Flexi Time Target']
${Monday}    //android.widget.TextView[@text='Monday']
${Tuesday}    //android.widget.TextView[@text='Tuesday']
${Wednesday}    //android.widget.TextView[@text='Wednesday']
${Thursday}    //android.widget.TextView[@text='Thursday']
${Friday}    //android.widget.TextView[@text='Friday']
${Enable_Flexi_Time}    //android.widget.TextView[@text='Enable Flexi Time']
${Flexi_Time_Target_Name}    45:00
${Default_Flexi_Target_Time}    00:00
@{TargetList}    123    ${EMPTY}    ^%$#@!&*    測試格式    45:00

*** Keywords ***
Enter Options Page
    Wait Until Page Contains Element    ${OPTIONS_VIEW}
    Click Element    ${OPTIONS_VIEW}

Select Flexi Time Target
    Wait Until Page Contains Element    ${Flexi_Time_Target}
    Click Element    ${Flexi_Time_Target}
Edit Flexi Time Target
    Wait Until Page Contains Element    ${EDIT_TEXT_PANNEL}
    FOR    ${element}    IN    @{TargetList}
        Input Text    ${EDIT_TEXT_PANNEL}    ${element}
        Sleep    1
        IF    $element == '45:00'    BREAK
        Clear Text    ${EDIT_TEXT_PANNEL}
    END

Edit Flexi Time Target With Correct Input
    Wait Until Page Contains Element    ${EDIT_TEXT_PANNEL}
    Input Text    ${EDIT_TEXT_PANNEL}    45:00

Clear Default Target
    Wait Until Page Contains Element    ${EDIT_TEXT_PANNEL}
    Clear Text    ${EDIT_TEXT_PANNEL}

Select Working Day
    Wait Until Page Contains Element    ${Monday}
    Click Element    ${Monday}
    Wait Until Page Contains Element    ${Tuesday}
    Click Element    ${Tuesday}
    Wait Until Page Contains Element    ${Wednesday}
    Click Element    ${Wednesday}
    Wait Until Page Contains Element    ${Thursday}
    Click Element    ${Thursday}
    Wait Until Page Contains Element    ${Friday}
    Click Element    ${Friday}

Scroll Down And Check Element Exist
    [Arguments]    ${INPUT_TEXT}
    FOR    ${licznik}    IN RANGE    0    5
        Swipe By Percent  30    70    30    20
        ${el}    Run Keyword And Return Status    Wait Until Page Contains Element    ${INPUT_TEXT}
        log    ${el}
        Run Keyword If    ${el}     Exit For Loop
        ${licznik}    Set Variable    ${licznik}+1
    END

Scroll Up And Check Element Exist
    [Arguments]    ${INPUT_TEXT}
    FOR    ${licznik}    IN RANGE    0    5
        Swipe By Percent  30    20    30    70
        ${el}    Run Keyword And Return Status    Wait Until Page Contains Element    ${INPUT_TEXT}
        log    ${el}
        Run Keyword If    ${el}     Exit For Loop
        ${licznik}    Set Variable    ${licznik}+1
    END

Check Enable Flexi
    Wait Until Page Contains Element    ${Enable_Flexi_Time}
    Click Element    ${Enable_Flexi_Time}
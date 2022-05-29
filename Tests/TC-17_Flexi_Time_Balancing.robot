*** Setting ***
Resource    ../Resources/Main_resource.robot
Resource    ../Resources/Task_resource.robot


Test Setup    Run Keywords    Open TrackWorkTime Without Allow Permission
...    AND    Open Navigation Drawer
...    AND    Enter Options Page

Test Teardown    Run Keywords    Open Navigation Drawer
...    AND    Enter Options Page
...    AND    Check Enable Flexi
...    AND    Back To Main Page
...    AND    Sleep    2
...    AND    Close Application


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

*** Keywords ***
Enter Options Page
    Wait Until Page Contains Element    ${OPTIONS_VIEW}
    Click Element    ${OPTIONS_VIEW}

Select Flexi Time Target
    Wait Until Page Contains Element    ${Flexi_Time_Target}
    Click Element    ${Flexi_Time_Target}
Edit Flexi Time Target
    Wait Until Page Contains Element    ${EDIT_TEXT_PANNEL}
    Input Text    ${EDIT_TEXT_PANNEL}    ${Flexi_Time_Target_Name}

Teardown Flexi Time Target
    Wait Until Page Contains Element    ${EDIT_TEXT_PANNEL}
    Input Text    ${EDIT_TEXT_PANNEL}    ${Default_Flexi_Target_Time}

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

*** Test Cases ***
Flexi Time Balancing
    Select Flexi Time Target
    Clear Default Target
    Edit Flexi Time Target
    Click OK Button
    Sleep    1
    Scroll Down And Check Element Exist    ${Friday}
    Select Working Day
    Sleep    1
    Scroll Up And Check Element Exist    ${Enable_Flexi_Time}
    Check Enable Flexi
    Back To Main Page
    Sleep    1
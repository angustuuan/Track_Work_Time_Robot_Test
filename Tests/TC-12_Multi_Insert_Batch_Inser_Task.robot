*** Setting ***
Resource    ../Resources/Main_resource.robot
Resource    ../Resources/Task_resource.robot

Test Setup    Run Keywords    Open TrackWorkTime Without Allow Permission
...    AND    Open Navigation Drawer
...    AND    Enter Options Page
...    AND    Select Flexi Time Target
...    AND    Clear Default Target
...    AND    Edit Flexi Time Target
...    AND    Click OK Button
...    AND    Sleep    1
...    AND    Scroll Down And Check Element Exist    ${Friday}
...    AND    Select Working Day
...    AND    Sleep    1
...    AND    Scroll Up And Check Element Exist    ${Enable_Flexi_Time}
...    AND    Check Enable Flexi
...    AND    Back To Main Page

Test Teardown    Run Keywords    Open Navigation Drawer
...    AND    Enter Options Page
...    AND    Check Enable Flexi
...    AND    Sleep    1
...    AND    Scroll Down And Check Element Exist    ${Friday}
...    AND    Select Working Day
...    AND    Sleep    1
...    AND    Scroll Up And Check Element Exist    ${Enable_Flexi_Time}
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

${MULTI_INSERT_VIEW}    //android.widget.CheckedTextView[@text='Multi-Insert']
${EDIT_EVENTS_VIEW}    //android.widget.CheckedTextView[@text='Edit Events']
${MULTI_INSERT_BUTTON}    //android.widget.Button[@text='MULTI-INSERT']
${DATEFROM}    //android.widget.TextView[@id=dateFrom]
#${DATETO}    //android.widget.DatePicker

#修UIAutomatorViewer
#定位日期
#選日期
#判斷edit events 內容正確
#考慮要不要判斷文字顏色改變
*** Test Cases ***
Batch insert task
    [Tags]    DEBUG
    Open Navigation Drawer
    Wait Until Page Contains Element    ${MULTI_INSERT_VIEW}
    Click Element    ${MULTI_INSERT_VIEW}
#    Get Element Attribute ${DATEFROM}
#    Click Element    ${DATEFROM}
#    Click OK Button
    Wait Until Page Contains Element    ${MULTI_INSERT_BUTTON}
    Click Element    ${MULTI_INSERT_BUTTON}
    Open Navigation Drawer
    Wait Until Page Contains Element    ${EDIT_EVENTS_VIEW}
    Click Element    ${EDIT_EVENTS_VIEW}
    Back To Main Page


*** Keywords ***

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
*** Setting ***
Resource    ../Resources/Main_resource.robot
Resource    ../Resources/Task_resource.robot
Resource    ../Resources/Event_resource.robot

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
#-------------------------------------------------------------------------------
${MULTI_INSERT_VIEW}    //android.widget.CheckedTextView[@text='Multi-Insert']
${MULTI_INSERT_BUTTON}    //android.widget.Button[@text='MULTI-INSERT']



*** Test Cases ***
Batch insert task
    Open Navigation Drawer
    Entet Muliti Insert Page
    Select DateFrom
    Click OK Button
    Select DateTo
    Click OK Button
    Click Multi Insert Button
    Open Navigation Drawer
    Enter Edit Events Page
    Verify Day Text And Event Text
    Back To Main Page


*** Keywords ***
Verify Day Text And Event Text
    Wait Until Page Contains Element   //android.widget.TextView[@index='0']
    Element Should Contain Text   //android.widget.TextView[@index='0']      Monday
    Element Should Contain Text   //android.widget.TextView[@index='3']      Tuesday
    Element Should Contain Text   //android.widget.TextView[@index='6']      Wednesday
    Element Should Contain Text   //android.widget.TextView[@index='9']      Thursday
    Element Should Contain Text   //android.widget.TextView[@index='12']      Friday

    FOR    ${event_index}    IN RANGE    0    4
        Element Text Should Be   //android.view.ViewGroup[@index=1+${event_index}*3]//android.widget.TextView[@index='2']      Default
    END
Select DateFrom
    Wait Until Page Contains Element    //android.widget.TextView[@index='2']
    Click Element    //android.widget.TextView[@index='2']
    Sleep    2
    ${DATEPICKER_TITLE}	Get Text	//android.widget.TextView[@index='1']
    @{words} =  Split String    ${DATEPICKER_TITLE}
    ${Day} =	Get From List	${words}	0
    ${Date} =	Get From List	${words}	2
    Pick Date    ${Day}  ${Date}  'DateFrom'

Select DateTo
    Wait Until Page Contains Element    //android.widget.TextView[@index='4']
    Click Element    //android.widget.TextView[@index='4']
    Sleep    2
    ${DATEPICKER_TITLE}	Get Text	//android.widget.TextView[@index='1']
    @{words} =  Split String    ${DATEPICKER_TITLE}
    ${Day} =	Get From List	${words}	0
    ${Date} =	Get From List	${words}	2
    Pick Date    ${Day}  ${Date}  'DateTo'

Pick Date
    [Arguments]    ${Day}   ${Date}   ${PickType}
    ${value}  Set Variable    0
    IF   ${PickType} == 'DateTo'
        ${value}  Set Variable    6
    END

    IF  '${Day}' == 'Mon,'
        Click Element   //android.view.View[@index=${Date}-1+${value}]
    ELSE IF  '${Day}' == 'Tue,'
        Click Element   //android.view.View[@index=${Date}-2+${value}]
    ELSE IF  '${Day}' == 'Wed,'
        Click Element   //android.view.View[@index=${Date}-3+${value}]
    ELSE IF  '${Day}' == 'Thr,'
        Click Element   //android.view.View[@index=${Date}-4+${value}]
    ELSE IF  '${Day}' == 'Fri,'
        Click Element   //android.view.View[@index=${Date}-5+${value}]
    ELSE IF  '${Day}' == 'Sat,'
        Click Element   //android.view.View[@index=${Date}-6+${value}]
    ELSE
        Click Element   //android.view.View[@index=${Date}-7+${value}]
    END


Entet Muliti Insert Page
    Wait Until Page Contains Element    ${MULTI_INSERT_VIEW}
    Click Element    ${MULTI_INSERT_VIEW}


Click Multi Insert Button
    Wait Until Page Contains Element    ${MULTI_INSERT_BUTTON}
    Click Element    ${MULTI_INSERT_BUTTON}

#---------------------------------------------------------------------------

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
*** Setting ***
Resource    ../Resources/Main_resource.robot
Resource    ../Resources/Task_resource.robot
Resource    ../Resources/Event_resource.robot
Resource    ../Resources/Flexi_Time_Balancing_resource.robot

Test Setup    Run Keywords    Open TrackWorkTime Without Allow Permission
...    AND    Open Navigation Drawer
...    AND    Enter Options Page
...    AND    Select Flexi Time Target
...    AND    Clear Default Target
...    AND    Edit Flexi Time Target With Correct Input
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
...    AND    Sleep    1
...    AND    Select Working Day
...    AND    Back To Main Page
...    AND    Sleep    2
...    AND    Close Application

*** Variables ***
${MULTI_INSERT_VIEW}    //android.widget.CheckedTextView[@text='Multi-Insert']
${MULTI_INSERT_BUTTON}    //android.widget.Button[@text='MULTI-INSERT']
${HOLIDAY_RADIO}    //android.widget.RadioButton[@text='Holiday / vacation / non-working day']
${CHANGE_TARGET_TIME_RADIO}    //android.widget.RadioButton[@text='Change target time']
${EDIT_TEXT}    //android.widget.EditText[@index='12']
${NON_WORKING_DAY_CHECKBOX}     //android.widget.CheckBox[@text='also on non-working days']
${TARGET_TYPE}      //android.widget.Spinner[@index='2']//android.widget.TextView[@index='0']
${TARGET_TIME_EDIT_TEXT}     //android.widget.EditText[@index='14']
${TARGET_TIME_IN_A_WEEK}    //android.widget.TableRow[@index='8']//android.widget.TextView[@index='2']
@{TargetList}    123    ${EMPTY}    ^%$#@!&*    測試格式    2:00

*** Test Cases ***
TC-25 Batch insert task
    Open Navigation Drawer
    Entet Muliti Insert Page
    Select DateFrom At This Monday
    Click OK Button
    Select DateTo At This Sunday
    Click OK Button
    Click widget    ${MULTI_INSERT_BUTTON}
    Open Navigation Drawer
    Enter Edit Events Page
    Verify Day Text And Event Text
    Back To Main Page

TC-26 Batch insert Holidays
    Open Navigation Drawer
    Entet Muliti Insert Page
    Select DateFrom At This Monday
    Click OK Button
    Select DateTo At This Sunday
    Click OK Button
    Click widget    ${HOLIDAY_RADIO}
    Edit Multi Insert Text
    Click widget    ${NON_WORKING_DAY_CHECKBOX}
    Click widget    ${MULTI_INSERT_BUTTON}
    Verify Holiday In A Week

TC-27 Change Target Time At Working Day
     Open Navigation Drawer
    Entet Muliti Insert Page
    Select DateFrom At This Monday
    Click OK Button
    Select DateTo At This Sunday
    Click OK Button
    Click widget    ${CHANGE_TARGET_TIME_RADIO}
    Edit Target Time Text
    Click widget    ${MULTI_INSERT_BUTTON}
    Sleep   1
    Element Text Should Be     ${TARGET_TIME_IN_A_WEEK}    -10:00


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

Verify Holiday In A Week
    FOR    ${day_index}    IN RANGE    1    8
        Sleep    1
        Click Element   //android.widget.TableRow[@index=${day_index}]//android.widget.TextView[@index='0']
        Sleep    1
        Element Should Contain Text     ${TARGET_TYPE}    Holiday / vacation / non-working day
        Element Should Contain Text     //android.widget.EditText[@index='0']       Vacation
        Back To Main Page
    END

Select DateFrom At This Monday
    Wait Until Page Contains Element    //android.widget.TextView[@index='2']
    Click Element    //android.widget.TextView[@index='2']
    Sleep    2
    ${DATEPICKER_TITLE}	Get Text	//android.widget.TextView[@index='1']
    @{words} =  Split String    ${DATEPICKER_TITLE}
    ${Day} =	Get From List	${words}	0
    ${Date} =	Get From List	${words}	2
    Pick Date    ${Day}  ${Date}  'DateFrom'

Select DateTo At This Sunday
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

Edit Multi Insert Text
    Wait Until Page Contains Element    ${EDIT_TEXT}
    Input Text    ${EDIT_TEXT}    Vacation

Click widget
    [Arguments]    ${Widge}
    Wait Until Page Contains Element    ${Widge}
    Click Element    ${Widge}

Edit Target Time Text
    Wait Until Page Contains Element    ${TARGET_TIME_EDIT_TEXT}
    FOR    ${element}    IN    @{TargetList}
        Input Text    ${TARGET_TIME_EDIT_TEXT}    ${element}
        Sleep    1
        IF    $element == '2:00'    BREAK
        Clear Text    ${TARGET_TIME_EDIT_TEXT}
    END
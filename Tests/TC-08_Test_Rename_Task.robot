*** Setting ***
Library  String
Resource    ../Resources/Main_resource.robot
Resource    ../Resources/Task_resource.robot

Test Setup    Run Keywords    Open TrackWorkTime Without Allow Permission
...    AND    Open Navigation Drawer
...    AND    Enter Edit Tasks Page
...    AND    Create Task    ${ORIGINAL_TASK_NAME}
Test Teardown    Run Keywords    Delete Task    ${ORIGINAL_TASK_NAME}
...    AND    Close Application

*** Variables ***
${ORIGINAL_TASK_NAME}    ORIGINAL_NAME
${ORIGIN_TASK_XPATH}    //android.widget.TextView[@text='${ORIGINAL_TASK_NAME}']
&{UPDATED_TASK_NAME}    English=RobotTest    Chinese=自動化測試    Number=9487
...    Symbol=^%$#@!&*(    Mixed=!*自動化Test321    Empty=${EMPTY}

*** Test Cases ***
TC-16 Rename Task With Different Task Name
    [Template]    Rename Task
    ${UPDATED_TASK_NAME}[English]
    ${UPDATED_TASK_NAME}[Chinese]
    ${UPDATED_TASK_NAME}[Number]
    ${UPDATED_TASK_NAME}[Symbol]
    ${UPDATED_TASK_NAME}[Mixed]
    ${UPDATED_TASK_NAME}[Empty]

TC-17 Rename Task With Random Task Name
    ${RANDOM} =    Generate Random String
    Rename Task    ${RANDOM}

TC-18 Task Should Not Rename When Cancel
    Click Task    ${ORIGIN_TASK_XPATH}
    Click Rename Task
    Clear Input Task Name
    Input Task Name    ${UPDATED_TASK_NAME}[English]
    Click CANCEL Button
    Wait Until Page Contains Element    //android.widget.TextView[@text='${ORIGINAL_TASK_NAME}']
    Page Should Contain Element    //android.widget.TextView[@text='${ORIGINAL_TASK_NAME}']

*** Keywords ***
Rename Task
    [Arguments]    ${UPDATED_TASK_NAME}
    Click Task    ${ORIGIN_TASK_XPATH}
    Click Rename Task
    Clear Input Task Name
    Input Task Name    ${UPDATED_TASK_NAME}
    Click OK Button
    Wait Until Page Contains Element    //android.widget.TextView[@text='${UPDATED_TASK_NAME}']
    Page Should Contain Element    //android.widget.TextView[@text='${UPDATED_TASK_NAME}']
    [Teardown]    Rename Task To Original Name    ${UPDATED_TASK_NAME}

Rename Task To Original Name
    [Arguments]    ${UPDATED_TASK_NAME}
    Click Task    //android.widget.TextView[@text='${UPDATED_TASK_NAME}']
    Click Rename Task
    Clear Input Task Name
    Input Task Name    ${ORIGINAL_TASK_NAME}
    Click OK Button


*** Setting ***
Library  String
Resource    ../Resources/Main_resource.robot
Resource    ../Resources/Task_resource.robot

Test Setup    Run Keywords    Open TrackWorkTime Without Allow Permission
...    AND    Open Navigation Drawer
...    AND    Enter Edit Tasks Page
Test Teardown    Close Application

*** Variables ***
&{TASK_NAME}    English=RobotTest    Chinese=自動化測試    Number=9487
...    Symbol=^%$#@!&*(    Mixed=!*自動化Test321    Empty=${EMPTY}

*** Test Cases ***
Create Task With Different Task Name
    [Template]    New Task
    ${TASK_NAME}[English]
    ${TASK_NAME}[Chinese]
    ${TASK_NAME}[Number]
    ${TASK_NAME}[Symbol]
    ${TASK_NAME}[Mixed]
    ${TASK_NAME}[Empty]

Create Task With Random Task Name
    ${RANDOM} =    Generate Random String
    New Task    ${RANDOM}

Task Should Not Create When Cancel
    Select New Task
    Input Task Name    ${TASK_NAME}[English]
    Click Cancel Button
    Wait Until Page Does Not Contain Element    //android.widget.TextView[@text='${TASK_NAME}[English]']
    Page Should Not Contain Element    //android.widget.TextView[@text='${TASK_NAME}[English]']

*** Keywords ***
New Task
    [Arguments]    ${TASK_NAME}
    Create Task    ${TASK_NAME}
    [Teardown]    Delete Task    ${TASK_NAME}
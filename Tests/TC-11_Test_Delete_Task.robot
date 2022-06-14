*** Setting ***
Library  String
Resource    ../Resources/Main_resource.robot
Resource    ../Resources/Task_resource.robot

Test Setup    Run Keywords    Open TrackWorkTime Without Allow Permission
...    AND    Open Navigation Drawer
...    AND    Enter Edit Tasks Page
Test Teardown    Close Application

*** Variables ***
${Target_Task}    del_target


*** Test Cases ***
Delete Task
    New Task    ${Target_Task}
    Delete Task    ${Target_Task}

Task Should Not Delete When Cancel
    New Task    ${Target_Task}
    Delete Cancel    ${Target_Task}


*** Keywords ***
New Task
    [Arguments]    ${TASK_NAME}
    Create Task    ${TASK_NAME}

Delete Cancel
    [Arguments]    ${TASK_NAME}
    Click Task    //android.widget.TextView[@text='${TASK_NAME}']
    Click Delete Task
    Sleep    1
    Click Cancel Button
    Wait Until Page Contains Element    //android.widget.TextView[@text='${TASK_NAME}']
    Page Should Contain Element    //android.widget.TextView[@text='${TASK_NAME}']




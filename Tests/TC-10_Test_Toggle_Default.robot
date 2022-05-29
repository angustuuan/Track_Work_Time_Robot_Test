*** Setting ***
Resource    ../Resources/Main_resource.robot
Resource    ../Resources/Task_resource.robot

Test Setup    Run Keywords    Open TrackWorkTime Without Allow Permission
...    AND    Open Navigation Drawer
...    AND    Enter Edit Tasks Page
...    AND    Select New Task
...    AND    Input Task Name    ${TASK_NAME}
...    AND    Click OK Button
Test Teardown    Run Keywords    Open Navigation Drawer
...    AND    Enter Edit Tasks Page
...    AND    Click Task    ${ORIGIN_DEFAULT_TASK_XPATH}
...    AND    Click Toggle Default
...    AND    Click Task    ${ORIGIN_TASK_XPATH}
...    AND    Click Delete Task
...    AND    Click OK Button
...    AND    Close Application

*** Variables ***
${TASK_NAME}    ROBOT_TEST
${ORIGIN_TASK_XPATH}    //android.widget.TextView[@text='${TASK_NAME}']
${CURRENT_DEFAULT_TASK_NAME}    ROBOT_TEST *
${CURRENT_DEFAULT_TASK_XPATH}    //android.widget.TextView[@text='${CURRENT_DEFAULT_TASK_NAME}']

${MAIN_PAGE_DEFAULT_TASK_XPATH}    //android.widget.TextView[@text='${CURRENT_DEFAULT_TASK_NAME}']
${ORIGIN_DEFAULT_TASK_XPATH}    //android.widget.TextView[@text='Default']

*** Test Cases ***
Toggle Default
    Click Task    ${ORIGIN_TASK_XPATH}
    Click Toggle Default
    Page Should Contain Element    ${CURRENT_DEFAULT_TASK_XPATH}
    Verify Default Task Show In Main Page

*** Keywords ***
Verify Default Task Show In Main Page
    Back To Main Page
    Page Should Contain Element    ${MAIN_PAGE_DEFAULT_TASK_XPATH}


*** Setting ***
Resource    ../Resources/Main_resource.robot
Resource    ../Resources/Task_resource.robot

Test Setup    Run Keywords    Open TrackWorkTime Without Allow Permission
...    AND    Open Navigation Drawer
...    AND    Enter Edit Tasks Page
...    AND    Select New Task
...    AND    Input Task Name    ${TASK_NAME}
...    AND    Click OK Button
Test Teardown    Run Keywords    Click Task    ${UPDATED_TASK_XPATH}
...    AND    Click Delete Task
...    AND    Click OK Button
...    AND    Close Application

*** Variables ***
${TASK_NAME}    ROBOT_TEST
${ORIGIN_TASK_XPATH}    //android.widget.TextView[@text='${TASK_NAME}']
${UPDATED_TASK_NAME}    REGRESSION_TEST
${UPDATED_TASK_XPATH}    //android.widget.TextView[@text='${UPDATED_TASK_NAME}']

*** Test Cases ***
Rename Task
    Click Task    ${ORIGIN_TASK_XPATH}
    Click Rename Task
    Clear Input Task Name
    Input Task Name    ${UPDATED_TASK_NAME}
    Click OK Button
    Verify Expected Task Show In Edit Tasks Page    ${UPDATED_TASK_XPATH}


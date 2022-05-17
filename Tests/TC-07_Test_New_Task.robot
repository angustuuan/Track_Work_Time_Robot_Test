*** Setting ***
Resource    ../Resources/Main_resource.robot
Resource    ../Resources/Task_resource.robot

Test Setup    Run Keywords    Open TrackWorkTime Without Allow Permission
...    AND    Open Navigation Drawer
...    AND    Enter Edit Tasks Page
Test Teardown    Run Keywords    Click Task    ${NEW_TASK_XPATH}
...    AND    Click Delete Task
...    AND    Click OK Button
...    AND    Close Application

*** Variables ***
${TASK_NAME}    ROBOT_TEST
${NEW_TASK_XPATH}    //android.widget.TextView[@text='${TASK_NAME}']

*** Test Cases ***
New Task
    Select New Task
    Input Task Name    ${TASK_NAME}
    Click OK Button
    Verify Expected Task Show In Edit Tasks Page    ${NEW_TASK_XPATH}
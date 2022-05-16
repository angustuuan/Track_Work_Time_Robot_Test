*** Setting ***
Resource    ../Resources/Main_resource.robot
Resource    ../Resources/Task_resource.robot

Test Setup    Open TrackWorkTime Without Allow Permission
Test Teardown    Run Keywords    Delete Task    ${EXPECTED_TASK_XPATH}    AND    Close Application

*** Variables ***
#*** Test Data ***
${INPUT_TEXT}    ROBOT_TEST
${EXPECTED_TASK_XPATH}    //android.widget.TextView[@text='${INPUT_TEXT}']

*** Test Cases ***
New Task
    Open Navigation Drawer
    Enter Edit Tasks Page
    Select New Task
    Enter Task Name    ${INPUT_TEXT}
    Click OK Button
    Verify Added Task Show In Edit Tasks Page    ${EXPECTED_TASK_XPATH}


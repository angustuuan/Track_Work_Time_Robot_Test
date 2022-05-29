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
...    AND    Click Task    ${TASK_XPATH}
...    AND    Click Delete Task
...    AND    Click OK Button
...    AND    Close Application

*** Variables ***
${TASK_NAME}    ROBOT_TEST
${TASK_XPATH}    //android.widget.TextView[@text='${TASK_NAME}']

${MAIN_PAGE_SELECT_TASK_XPATH}    //android.widget.TextView[@text='Default *']
${MAIN_PAGE_ADDED_TASK_XPATH}    //android.widget.CheckedTextView[@text='${TASK_NAME}']
${MAIN_PAGE_DEFAULT_TASK_XPATH}    //android.widget.CheckedTextView[@text='Default *']

${SHOULD_SHOW}    True
${SHOULD_NOT_SHOW}    False

*** Test Cases ***
Toggle Activation State
    Verify If Task Show In Main Page    ${SHOULD_SHOW}
    Open Navigation Drawer
    Enter Edit Tasks Page
    Click Task    ${TASK_XPATH}
    Click Toggle Activation State
    Click OK Button
    Verify If Task Show In Main Page    ${SHOULD_NOT_SHOW}

*** Keywords ***
Verify If Task Show In Main Page
    [Arguments]    ${ACTIVATION_STATE}
    Back To Main Page
    Wait Until Page Contains Element    ${MAIN_PAGE_SELECT_TASK_XPATH}
    Click Element    ${MAIN_PAGE_SELECT_TASK_XPATH}
    IF    ${ACTIVATION_STATE}
        Wait Until Page Contains Element    ${MAIN_PAGE_ADDED_TASK_XPATH}
        Page Should Contain Element    ${MAIN_PAGE_ADDED_TASK_XPATH}
    ELSE
        Wait Until Page Does Not Contain Element    ${MAIN_PAGE_ADDED_TASK_XPATH}
        Page Should Not Contain Element    ${MAIN_PAGE_ADDED_TASK_XPATH}
    END
    Click Element    ${MAIN_PAGE_DEFAULT_TASK_XPATH}



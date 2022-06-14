*** Setting ***
Resource    ../Resources/Main_resource.robot
Resource    ../Resources/Task_resource.robot

Test Setup    Run Keywords    Open TrackWorkTime Without Allow Permission
...    AND    Open Navigation Drawer
...    AND    Enter Edit Tasks Page
...    AND    Create Task    ${TASK_NAME}
Test Teardown    Run Keywords    Open Navigation Drawer
...    AND    Enter Edit Tasks Page
...    AND    Delete Task    ${TASK_NAME}
...    AND    Close Application

*** Variables ***
${TASK_NAME}    RobotTest
${TASK_XPATH}    //android.widget.TextView[@text='${TASK_NAME}']

${MAIN_PAGE_SELECT_TASK_XPATH}    //android.widget.TextView[@text='Default *']
${MAIN_PAGE_ADDED_TASK_XPATH}    //android.widget.CheckedTextView[@text='${TASK_NAME}']
${MAIN_PAGE_DEFAULT_TASK_XPATH}    //android.widget.CheckedTextView[@text='Default *']

${ENABLE}    True
${DISABLE}    False

*** Test Cases ***
TC-19 Toggle Activation State To Disable
    Toggle Activation    ${DISABLE}

TC-20 Toggle Activation State To Enable
    Toggle Activation    ${DISABLE}
    Open Navigation Drawer
    Enter Edit Tasks Page
    Toggle Activation    ${ENABLE}

TC-21 Activation State Should Not Change When Cancel
    Click Task    ${TASK_XPATH}
    Click Toggle Activation State
    Click CANCEL Button
    Verify If Task Show In Main Page    ${ENABLE}

*** Keywords ***
Toggle Activation
    [Arguments]    ${ACTIVATION_STATE}
    Click Task    ${TASK_XPATH}
    Click Toggle Activation State
    Click OK Button
    Verify If Task Show In Main Page    ${ACTIVATION_STATE}

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



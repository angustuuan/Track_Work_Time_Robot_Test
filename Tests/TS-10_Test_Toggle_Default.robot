*** Setting ***
Resource    ../Resources/Main_resource.robot
Resource    ../Resources/Task_resource.robot

Test Setup    Run Keywords    Open TrackWorkTime Without Allow Permission
...    AND    Open Navigation Drawer
...    AND    Enter Edit Tasks Page
...    AND    Create Task    ${TASK_NAME}
Test Teardown    Run Keywords    Open Navigation Drawer
...    AND    Enter Edit Tasks Page
...    AND    Toggle Default    ${DEFAULT_XPATH_IN_MAIN_PAGE}
...    AND    Delete Task    ${TASK_NAME}
...    AND    Close Application

*** Variables ***
${TASK_NAME}    RobotTest
${TASK_NAME_WHEN_DEFAULT}    RobotTest *
${TASK_XPATH}    //android.widget.TextView[contains(@text, '${TASK_NAME}')]
${TASK_XPATH_IN_MAIN_PAGE}    //android.widget.TextView[contains(@text, '${TASK_NAME}')]
${DEFAULT_XPATH_IN_MAIN_PAGE}    //android.widget.TextView[contains(@text, 'Default')]

*** Test Cases ***
TC-22 Set Task To Default
    Toggle Default    ${TASK_XPATH}
    Element Text Should Be    ${TASK_XPATH}    ${TASK_NAME_WHEN_DEFAULT}
    Verify Default Task Show In Main Page    ${TASK_XPATH_IN_MAIN_PAGE}

TC-23 Set Task To Non-default
    Toggle Default    ${TASK_XPATH}
    Element Text Should Be    ${TASK_XPATH}    ${TASK_NAME_WHEN_DEFAULT}
    Toggle Default    ${TASK_XPATH}
    Element Text Should Be    ${TASK_XPATH}    ${TASK_NAME}
    Verify Default Task Show In Main Page    ${DEFAULT_XPATH_IN_MAIN_PAGE}

*** Keywords ***
Toggle Default
    [Arguments]    ${TASK_XPATH_TO_TOGGLE}
    Click Task    ${TASK_XPATH_TO_TOGGLE}
    Click Toggle Default

Verify Default Task Show In Main Page
    [Arguments]    ${EXPECTED_TASK_XPATH}
    Back To Main Page
    Page Should Contain Element    ${EXPECTED_TASK_XPATH}


*** Setting ***
Resource    ../Resources/Main_resource.robot
Resource    ../Resources/Event_resource.robot

Test Setup    Run Keywords    Open TrackWorkTime Without Allow Permission
...    AND    Open Navigation Drawer
...    AND    Create Task Then Enter Edit Events Page    ${TASK_NAME}
...    AND    Select New Event
...    AND    Click Save Changes Button
Test Teardown    Run Keywords    Delete First Event
...    AND    Close Application

*** Variables ***
${TASK_NAME}    RobotTest

*** Test Cases ***
Edit Event To Start Tracking With Different Specific Data
    [Template]    Edit Event To Start Tracking
    ${TASK_NAME}    1    0    AM    Test Message.
    ${TASK_NAME}    6    10    AM    中文訊息。
    ${TASK_NAME}    11    59    PM    110598027
    ${TASK_NAME}    01    01    PM    ^%$#@!&*
    ${TASK_NAME}    12    1    PM    Mess訊息^%110

Edit Event To Stop Tracking With Different Specific Data
    [Template]    Edit Event To Stop Tracking
    12    0    AM
    01    01    PM

*** Keywords ***
Edit Event To Start Tracking
    [Arguments]    ${TASK_NAME}    ${HOUR}    ${MINUTEHOUR}    ${AM_PM}    ${EVENT_HINT}
    Click Event    ${FIRST_EVENT_XPATH}
    Click Start Tracking Radio Button
    Click Event Date
    Click OK Button
    ${expected_date} =    Get Element Attribute    ${DATE_VIEW}   text
    Click Event Time
    Input Event Time    ${HOUR}    ${MINUTEHOUR}     ${AM_PM}
    Click OK Button
    ${expected_time} =    Get Element Attribute    ${TIME_VIEW}   text
    Select Event Task    ${TASK_NAME}
    Input Event Hint    ${EVENT_HINT}
    Click Save Changes Button
    Check First Event Detail    ${expected_date}    ${expected_time}    IN    ${TASK_NAME}

Edit Event To Stop Tracking
    [Arguments]    ${HOUR}    ${MINUTEHOUR}    ${AM_PM}
    Click Event    ${FIRST_EVENT_XPATH}
    Click Stop Tracking Radio Button
    Click Event Date
    Click OK Button
    ${expected_date} =    Get Element Attribute    ${DATE_VIEW}   text
    Click Event Time
    Input Event Time    ${HOUR}    ${MINUTEHOUR}     ${AM_PM}
    Click OK Button
    ${expected_time} =    Get Element Attribute    ${TIME_VIEW}   text
    Click Save Changes Button
    Check First Event Detail    ${expected_date}    ${expected_time}    OUT

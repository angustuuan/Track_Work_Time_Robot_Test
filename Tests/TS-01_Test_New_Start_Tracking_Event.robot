*** Setting ***
Resource    ../Resources/Main_resource.robot
Resource    ../Resources/Event_resource.robot

Test Setup    Run Keywords    Open TrackWorkTime Without Allow Permission
...    AND    Open Navigation Drawer
...    AND    Create Task Then Enter Edit Events Page    ${TASK_NAME}
Test Teardown    Run Keywords    Close Application

*** Variables ***
${TASK_NAME}    RobotTest

*** Test Cases ***
TC-01 Create Multiple Default Events
    Select New Event
    Click Save Changes Button
    Select New Event
    Click Save Changes Button
    Wait Until Page Contains Element    ${FIRST_EVENT_DATE_VIEW}
    Page Should Contain Element    ${FIRST_EVENT_DATE_VIEW}
    Delete First Event
    Delete First Event
    Wait Until Page Does Not Contain Element    ${FIRST_EVENT_DATE_VIEW}
    Page Should Not Contain Element    ${FIRST_EVENT_DATE_VIEW}

TC-02 Event Should Not Create When Cancel
    Select New Event
    Click CANCEL Button
    Wait Until Page Does Not Contain Element    ${FIRST_EVENT_DATE_VIEW}
    Page Should Not Contain Element    ${FIRST_EVENT_DATE_VIEW}

TC-03 Create Event With Different Specific Data
    [Template]    Create Event
    ${TASK_NAME}    1    0    AM    Test Message.
    ${TASK_NAME}    6    10    AM    中文訊息。
    ${TASK_NAME}    11    59    PM    110598027
    ${TASK_NAME}    01    01    PM    ^%$#@!&*
    ${TASK_NAME}    12    1    PM    Mess訊息^%110

*** Keywords ***
Create Event
    [Arguments]    ${TASK_NAME}    ${HOUR}    ${MINUTEHOUR}    ${AM_PM}    ${EVENT_HINT}
    Select New Event
    Click Start Tracking Radio Button
    Click Event Date
    Click OK Button
    ${expected_date} =    Get Element Attribute    ${DATE_VIEW}   text
    Click Event Time
    Input Event Time    ${HOUR}    ${MINUTEHOUR}    ${AM_PM}
    Click OK Button
    ${expected_time} =    Get Element Attribute    ${TIME_VIEW}   text
    Select Event Task    ${TASK_NAME}
    Input Event Hint    ${EVENT_HINT}
    Click Save Changes Button
    Check First Event Detail    ${expected_date}    ${expected_time}    IN    ${TASK_NAME}
    Delete First Event

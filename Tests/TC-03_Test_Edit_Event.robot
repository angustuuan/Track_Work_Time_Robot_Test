*** Setting ***
Resource    ../Resources/Main_resource.robot
Resource    ../Resources/Event_resource.robot

Test Setup    Run Keywords    Open TrackWorkTime Without Allow Permission
...    AND    Open Navigation Drawer
...    AND    Enter Edit Events Page
Test Teardown    Run Keywords    Close Application

*** Test Cases ***
Create Multiple Default Events
    Select New Event
    Click Save Changes Button
    Click Event    ${FIRST_EVENT_XPATH}
    Click Stop Tracking Radio Button
    Click Event Date
    Click OK Button
    ${expected_date}=    Get Element Attribute    ${DATE_VIEW}   text
    Click Event Time
    Input Event Time    12    00    AM
    Click OK Button
    ${expected_time}=    Get Element Attribute    ${TIME_VIEW}   text
    Click Save Changes Button
    Check First Event Detail    ${expected_date}    ${expected_time}    OUT
    Delete First Event

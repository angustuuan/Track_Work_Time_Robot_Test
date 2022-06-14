*** Setting ***
Resource    ../Resources/Main_resource.robot
Resource    ../Resources/Event_resource.robot

Test Setup    Run Keywords    Open TrackWorkTime Without Allow Permission
...    AND    Open Navigation Drawer
...    AND    Enter Edit Events Page
Test Teardown    Run Keywords    Close Application

*** Test Cases ***
TC-04 Create Event With Specific Data
    [Template]    Create Event
    12    0    AM
    01    01    PM

*** Keywords ***
Create Event
    [Arguments]    ${HOUR}    ${MINUTEHOUR}    ${AM_PM}
    Select New Event
    Click Stop Tracking Radio Button
    Click Event Date
    Click OK Button
    ${expected_date} =    Get Element Attribute    ${DATE_VIEW}   text
    Click Event Time
    Input Event Time    ${HOUR}    ${MINUTEHOUR}    ${AM_PM}
    Click OK Button
    ${expected_time} =    Get Element Attribute    ${TIME_VIEW}   text
    Click Save Changes Button
    Check First Event Detail    ${expected_date}    ${expected_time}    OUT
    Delete First Event

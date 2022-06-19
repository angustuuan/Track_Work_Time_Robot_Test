*** Setting ***
Resource    ../Resources/Main_resource.robot
Resource    ../Resources/Task_resource.robot
Resource    ../Resources/Flexi_Time_Balancing_resource.robot

Test Setup    Run Keywords    Open TrackWorkTime Without Allow Permission
...    AND    Open Navigation Drawer
...    AND    Enter Options Page

Test Teardown    Run Keywords    Open Navigation Drawer
...    AND    Enter Options Page
...    AND    Check Enable Flexi
...    AND    Back To Main Page
...    AND    Sleep    2
...    AND    Close Application


*** Variables ***

*** Test Cases ***
TC-28 Flexi Time Balancing
    Select Flexi Time Target
    Clear Default Target
    Edit Flexi Time Target
    Click OK Button
    Sleep    1
    Scroll Down And Check Element Exist    ${Friday}
    Select Working Day
    Sleep    1
    Scroll Up And Check Element Exist    ${Enable_Flexi_Time}
    Check Enable Flexi
    Back To Main Page
    Sleep    1
    Swipe By Percent  20    25    70    25
    Swipe By Percent  20    25    70    25
    Swipe By Percent  70    25    20    25
    Swipe By Percent  70    25    20    25


*** Keywords ***



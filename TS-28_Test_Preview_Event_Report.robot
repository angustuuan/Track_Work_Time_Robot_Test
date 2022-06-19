*** Setting ***
Resource    ../Resources/Main_resource.robot
Resource    ../Resources/Task_resource.robot
Resource    ../Resources/Event_resource.robot
Resource    ../Resources/Flexi_Time_Balancing_resource.robot

Test Setup    Run Keywords    Open TrackWorkTime Without Allow Permission
...    AND    Open Navigation Drawer

Test Teardown    Close Application

*** Variables ***
&{REPORTS_TAB}    id=org.zephyrsoft.trackworktime:id/design_menu_item_text
&{RANGE_ALL_DATA_RADIO_BUTTON}    id=org.zephyrsoft.trackworktime:id/rangeAllData
&{EVENTS_ROW_ALL_EVENTS_RADIO_BUTTON}    id=org.zephyrsoft.trackworktime:id/groupingNone
&{PREVIEW_BUTTON}    id=org.zephyrsoft.trackworktime:id/reportPreview
&{EXPORT_BUTTON}    id=org.zephyrsoft.trackworktime:id/reportExport

*** Test Cases ***
TC-28 Preview Event Report
    Wait Until Page Contains Element    ${REPORTS_TAB}
    Click Element    ${RANGE_ALL_DATA_RADIO_BUTTON}
    Click Element    ${EVENTS_ROW_ALL_EVENTS_RADIO_BUTTON}
    Click Element    ${PREVIEW_BUTTON}
    Sleep    1
    Back To Main Page

*** Keywords ***
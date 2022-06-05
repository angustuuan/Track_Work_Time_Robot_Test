*** Setting ***
Library  String
Library  DateTime
Resource    ../Resources/Main_resource.robot
Resource    ../Resources/Task_resource.robot

Test Setup    Run Keywords    Open TrackWorkTime Without Allow Permission

Test Teardown    Close Application

*** Variables ***

${CLOCK_IN_BUTTON}    id=org.zephyrsoft.trackworktime:id/clockInButton
${CLOCK_OUT_BUTTON}    id=org.zephyrsoft.trackworktime:id/clockOutButton

${DATEA}    Get Current Date    result_format=%#I:%#M %p
${WEEK_TABLE}    id=org.zephyrsoft.trackworktime:id/weekTable

*** Test Cases ***
Stop Tracking Event
    Click Element    ${CLOCK_IN_BUTTON}

    Click Element    ${CLOCK_OUT_BUTTON}
    ${TIME}    Get Current Date    result_format=%#I:%M %p
    ${DATE_SHORT}    Get Current Date    result_format=%a, %#m/%#d
    ${DATE_LONG}    Get Current Date    result_format=%A, %#m/%#d/%y

    Element Should Be Disabled    ${CLOCK_OUT_BUTTON}
    Element Text Should Be    ${CLOCK_IN_BUTTON}    START TRACKING
    Element Text Should Be    //android.widget.TextView[@text='${DATE_SHORT}']//..//android.widget.TextView[@index='2']    ${TIME}

    Click Element    ${WEEK_TABLE}
    Wait Until Page Contains Element    //androidx.recyclerview.widget.RecyclerView
    Element Text Should Be    //androidx.recyclerview.widget.RecyclerView//android.widget.TextView[@index='0']    ${DATE_LONG}
    Element Text Should Be    //android.view.ViewGroup[@index='2']//android.widget.TextView[@index='0']    ${TIME}
    Element Text Should Be    //android.view.ViewGroup[@index='2']//android.widget.TextView[@index='1']    OUT
    Element Text Should Be    //android.view.ViewGroup[@index='2']//android.widget.TextView[@index='2']    ${EMPTY}

    Click Element    //android.view.ViewGroup[@index='2']
    Wait Until Page Contains Element    org.zephyrsoft.trackworktime:id/radioClockOut
    Element Attribute Should Match    org.zephyrsoft.trackworktime:id/radioClockOut    checked    True
    Element Text Should Be    org.zephyrsoft.trackworktime:id/date    ${DATE_LONG}
    Element Text Should Be    org.zephyrsoft.trackworktime:id/time    ${TIME}
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
${TASK_SPINNER}    id=org.zephyrsoft.trackworktime:id/task
${HINT}    id=org.zephyrsoft.trackworktime:id/text

${WEEK_TABLE}    id=org.zephyrsoft.trackworktime:id/weekTable

&{TASK_NAME}    Default=Default    TaskForTest=Task for test
&{HINT_CONTENT}    Default=${EMPTY}    English=TestHint
&{HINT_EXPECT}    Default=Hint (optional)    English=TestHint

*** Test Cases ***
TC-10 Strat New Period With Same Task And Hint
    Tracking Event With New Period    ${TASK_NAME}[Default]    ${TASK_NAME}[Default]    ${HINT_CONTENT}[Default]    ${HINT_EXPECT}[Default]    ${HINT_CONTENT}[Default]    ${HINT_EXPECT}[Default]

TC-11 Strat New Period With Different Task And Hint
    Open Navigation Drawer
    Enter Edit Tasks Page
    Create Task    ${TASK_NAME}[TaskForTest]
    Back To Main Page
    Wait Until Page Contains Element    ${TASK_SPINNER}
    Tracking Event With New Period    ${TASK_NAME}[Default]    ${TASK_NAME}[TaskForTest]    ${HINT_CONTENT}[Default]    ${HINT_EXPECT}[Default]    ${HINT_CONTENT}[English]    ${HINT_EXPECT}[English]

*** Keywords ***
Tracking Event With New Period
    [Arguments]    ${TASK_NAME_1}    ${TASK_NAME_2}    ${HINT_CONTENT_1}    ${HINT_EXPECT_1}    ${HINT_CONTENT_2}    ${HINT_EXPECT_2}
    Click Element    ${TASK_SPINNER}
    Wait Until Page Contains Element    //android.widget.CheckedTextView[contains(@text, '${TASK_NAME_1}')]
    Click Element    //android.widget.CheckedTextView[contains(@text, '${TASK_NAME_1}')]
    Input Text    ${HINT}    ${HINT_CONTENT_1}
    Click Element    ${CLOCK_IN_BUTTON}
    ${TIME_1}    Get Current Date    result_format=%#I:%M %p
    ${DATE_SHORT}    Get Current Date    result_format=%a, %#m/%#d
    ${DATE_LONG}    Get Current Date    result_format=%A, %#m/%#d/%y
    Element Text Should Be    ${CLOCK_IN_BUTTON}    START NEW PERIOD
    Click Element    ${TASK_SPINNER}
    Wait Until Page Contains Element    //android.widget.CheckedTextView[contains(@text, '${TASK_NAME_2}')]
    Click Element    //android.widget.CheckedTextView[contains(@text, '${TASK_NAME_2}')]
    Input Text    ${HINT}    ${HINT_CONTENT_2}
    Click Element    ${CLOCK_IN_BUTTON}
    ${TIME_2}    Get Current Date    result_format=%#I:%M %p
    ${DATE_SHORT}    Get Current Date    result_format=%a, %#m/%#d
    ${DATE_LONG}    Get Current Date    result_format=%A, %#m/%#d/%y

    Click Element    ${WEEK_TABLE}
    Wait Until Page Contains Element    //androidx.recyclerview.widget.RecyclerView
    Element Text Should Be    //androidx.recyclerview.widget.RecyclerView//android.widget.TextView[@index='0']    ${DATE_LONG}
    Element Text Should Be    //android.view.ViewGroup[@index='1']//android.widget.TextView[@index='0']    ${TIME_1}
    Element Text Should Be    //android.view.ViewGroup[@index='1']//android.widget.TextView[@index='1']    IN
    Element Text Should Be    //android.view.ViewGroup[@index='1']//android.widget.TextView[@index='2']    ${TASK_NAME_1}
    Element Text Should Be    //android.view.ViewGroup[@index='2']//android.widget.TextView[@index='0']    ${TIME_2}
    Element Text Should Be    //android.view.ViewGroup[@index='2']//android.widget.TextView[@index='1']    IN
    Element Text Should Be    //android.view.ViewGroup[@index='2']//android.widget.TextView[@index='2']    ${TASK_NAME_2}

    Click Element    //android.view.ViewGroup[@index='1']
    Wait Until Page Contains Element    org.zephyrsoft.trackworktime:id/radioClockIn
    Element Attribute Should Match    org.zephyrsoft.trackworktime:id/radioClockIn    checked    True
    Element Text Should Be    org.zephyrsoft.trackworktime:id/date    ${DATE_LONG}
    Element Text Should Be    org.zephyrsoft.trackworktime:id/time    ${TIME_1}
    Element Should Contain Text    android:id/text1    ${TASK_NAME_1}
    Element Text Should Be    org.zephyrsoft.trackworktime:id/text    ${HINT_EXPECT_1}

    Click Element    //android.widget.ImageButton[@content-desc='Navigate up']

    Wait Until Page Contains Element    //android.view.ViewGroup[@index='2']
    Click Element    //android.view.ViewGroup[@index='2']
    Wait Until Page Contains Element    org.zephyrsoft.trackworktime:id/radioClockIn
    Element Attribute Should Match    org.zephyrsoft.trackworktime:id/radioClockIn    checked    True
    Element Text Should Be    org.zephyrsoft.trackworktime:id/date    ${DATE_LONG}
    Element Text Should Be    org.zephyrsoft.trackworktime:id/time    ${TIME_2}
    Element Should Contain Text    android:id/text1    ${TASK_NAME_2}
    Element Text Should Be    org.zephyrsoft.trackworktime:id/text    ${HINT_EXPECT_2}
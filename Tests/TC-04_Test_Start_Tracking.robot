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
&{HINT_CONTENT}    Default=${EMPTY}    BlankSpace=${SPACE}    English=TestHint    Symbol=~!@#$%^&*()    NewLine=\n
&{HINT_EXPECT}    Default=Hint (optional)    BlankSpace=${SPACE}    English=TestHint    Symbol=~!@#$%^&*()    NewLine=\n

*** Test Cases ***
Tracking Event With Default Task And Hint
    Tracking Event    ${TASK_NAME}[Default]    ${HINT_CONTENT}[Default]    ${HINT_EXPECT}[Default]

Tracking Event With Task Selected
    New Task    ${TASK_NAME}[TaskForTest]
    Back To Main Page
    Wait Until Page Contains Element    ${TASK_SPINNER}
    Tracking Event    ${TASK_NAME}[TaskForTest]    ${HINT_CONTENT}[Default]    ${HINT_EXPECT}[Default]

Tracking Event With Hint Contain Blank Space
    Tracking Event    ${TASK_NAME}[Default]    ${HINT_CONTENT}[BlankSpace]    ${HINT_EXPECT}[BlankSpace]

Tracking Event With Hint Contain English
    Tracking Event    ${TASK_NAME}[Default]    ${HINT_CONTENT}[English]    ${HINT_EXPECT}[English]

Tracking Event With Hint Contain Symbol
    Tracking Event    ${TASK_NAME}[Default]    ${HINT_CONTENT}[Symbol]    ${HINT_EXPECT}[Symbol]

Tracking Event With Hint Contain NewLine
    Tracking Event    ${TASK_NAME}[Default]    ${HINT_CONTENT}[NewLine]    ${HINT_EXPECT}[NewLine]

*** Keywords ***
New Task
    [Arguments]    ${TASK_NAME}
    Open Navigation Drawer
    Enter Edit Tasks Page
    Select New Task
    Input Task Name    ${TASK_NAME}
    Click OK Button

Tracking Event
    [Arguments]    ${TASK_NAME}    ${HINT_CONTENT}    ${HINT_EXPECT}
    Click Element    ${TASK_SPINNER}
    Wait Until Page Contains Element    //android.widget.CheckedTextView[contains(@text, '${TASK_NAME}')]
    Click Element    //android.widget.CheckedTextView[contains(@text, '${TASK_NAME}')]
    Input Text    ${HINT}    ${HINT_CONTENT}
    Click Element    ${CLOCK_IN_BUTTON}
    ${TIME}    Get Current Date    result_format=%#I:%M %p
    ${DATE_SHORT}    Get Current Date    result_format=%a, %#m/%#d
    ${DATE_LONG}    Get Current Date    result_format=%A, %#m/%#d/%y

    Element Should Be Enabled    ${CLOCK_OUT_BUTTON}
    Element Text Should Be    ${CLOCK_IN_BUTTON}    START NEW PERIOD
    Element Text Should Be    //android.widget.TextView[@text='${DATE_SHORT}']//..//android.widget.TextView[@index='1']    ${TIME}

    Click Element    ${WEEK_TABLE}
    Wait Until Page Contains Element    //android.widget.TextView[@text='${DATE_LONG}']
    Page Should Contain Element    //android.widget.TextView[@text='${TIME}']
    Element Text Should Be    //android.widget.TextView[@text='${TIME}']//..//android.widget.TextView[@index='1']    IN
    Element Should Contain Text    //android.widget.TextView[@text='${TIME}']//..//android.widget.TextView[@index='2']    ${TASK_NAME}
    
    Click Element    //android.widget.TextView[@text='${TIME}']
    Wait Until Page Contains Element    org.zephyrsoft.trackworktime:id/radioClockIn
    Element Attribute Should Match    org.zephyrsoft.trackworktime:id/radioClockIn    checked    True
    Element Text Should Be    org.zephyrsoft.trackworktime:id/date    ${DATE_LONG}
    Element Text Should Be    org.zephyrsoft.trackworktime:id/time    ${TIME}
    Element Should Contain Text    android:id/text1    ${TASK_NAME}
    Element Text Should Be    org.zephyrsoft.trackworktime:id/text    ${HINT_EXPECT}
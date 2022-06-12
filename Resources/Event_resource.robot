*** Setting ***
Library    AppiumLibrary
Resource    ../Resources/Task_resource.robot

*** Variables ***
#***  First Event XPATH Of Edit Events List ***
${RECYCLERVIEW}    //androidx.recyclerview.widget.RecyclerView
${FIRST_EVENT_XPATH}    ${RECYCLERVIEW}//android.view.ViewGroup
${FIRST_EVENT_DATE_VIEW}    ${RECYCLERVIEW}//android.widget.TextView[@resource-id='android:id/title']
${FIRST_EVENT_TIME_VIEW}    ${FIRST_EVENT_XPATH}//android.widget.TextView[@resource-id='org.zephyrsoft.trackworktime:id/time']
${FIRST_EVENT_TYPE_VIEW}    ${FIRST_EVENT_XPATH}//android.widget.TextView[@resource-id='org.zephyrsoft.trackworktime:id/type']
${FIRST_EVENT_TASK_VIEW}    ${FIRST_EVENT_XPATH}//android.widget.TextView[@resource-id='org.zephyrsoft.trackworktime:id/task']

#*** Button XPATH ***
${EDIT_EVENTS_VIEW}    //android.widget.CheckedTextView[@text='Edit Events']
${NEW_EVENT_VIEW}    //android.widget.TextView[@text='New Event']
${DELETE_VIEW}    //android.widget.TextView[@content-desc='Delete']

${SAVE_CHANGES_BUTTON}    //android.widget.Button[@text='SAVE CHANGES']
${START_TRACKING_RADIO_BUTTON}    //android.widget.RadioButton[@text='Start Tracking']
${STOP_TRACKING_RADIO_BUTTON}    //android.widget.RadioButton[@text='Stop Tracking']
${DATE_VIEW}    //android.widget.TextView[@resource-id='org.zephyrsoft.trackworktime:id/date']
${TIME_VIEW}    //android.widget.TextView[@resource-id='org.zephyrsoft.trackworktime:id/time']
${TASK_SPINNER}    //android.widget.Spinner[@resource-id='org.zephyrsoft.trackworktime:id/task']
${HINT_EDIT_TEXT}    //android.widget.EditText[@resource-id='org.zephyrsoft.trackworktime:id/text']

${TIME_MODE_BUTTON}    //android.widget.ImageButton[@resource-id='android:id/toggle_mode']
${TIME_HOUR_EDIT_TEXT}    //android.widget.EditText[@resource-id='android:id/input_hour']
${TIME_MINUTE_EDIT_TEXT}    //android.widget.EditText[@resource-id='android:id/input_minute']
${AM_PM_SPINNER}    //android.widget.Spinner[@resource-id='android:id/am_pm_spinner']

*** Keywords ***
Enter Edit Events Page
    Wait Until Page Contains Element    ${EDIT_EVENTS_VIEW}
    Click Element    ${EDIT_EVENTS_VIEW}

Create Task Then Enter Edit Events Page
    [Arguments]    ${TASK_NAME}
    Enter Edit Tasks Page
    Create Task    ${TASK_NAME}
    Back To Main Page
    Open Navigation Drawer
    Enter Edit Events Page

Select New Event
    Wait Until Page Contains Element    ${MORE_OPTIONS_VIEW}
    Click Element    ${MORE_OPTIONS_VIEW}
    Wait Until Page Contains Element    ${NEW_EVENT_VIEW}
    Click Element    ${NEW_EVENT_VIEW}

Click Start Tracking Radio Button
    Wait Until Page Contains Element    ${START_TRACKING_RADIO_BUTTON}
    Click Element    ${START_TRACKING_RADIO_BUTTON}

Click Stop Tracking Radio Button
    Wait Until Page Contains Element    ${STOP_TRACKING_RADIO_BUTTON}
    Click Element    ${STOP_TRACKING_RADIO_BUTTON}

Click Event Date
    Wait Until Page Contains Element    ${DATE_VIEW}
    Click Element    ${DATE_VIEW}

Click Event Time
    Wait Until Page Contains Element    ${TIME_VIEW}
    Click Element    ${TIME_VIEW}

Input Event Time
    [Arguments]    ${INPUT_HOUR}    ${INPUT_MINUTE}    ${AM_PM}
    Wait Until Page Contains Element    ${TIME_MODE_BUTTON}
    Click Element    ${TIME_MODE_BUTTON}
    Wait Until Page Contains Element    ${TIME_HOUR_EDIT_TEXT}
    Input Text    ${TIME_HOUR_EDIT_TEXT}    ${INPUT_HOUR}
    Wait Until Page Contains Element    ${TIME_MINUTE_EDIT_TEXT}
    Input Text    ${TIME_MINUTE_EDIT_TEXT}    ${INPUT_MINUTE}
    Wait Until Page Contains Element    ${AM_PM_SPINNER}
    Click Element    ${AM_PM_SPINNER}
    Wait Until Page Contains Element    //android.widget.CheckedTextView[@text='${AM_PM}']
    Click Element    //android.widget.CheckedTextView[@text='${AM_PM}']

Select Event Task
    [Arguments]    ${TASK_NAME}
    Wait Until Page Contains Element    ${TASK_SPINNER}
    Click Element    ${TASK_SPINNER}
    Wait Until Page Contains Element    //android.widget.CheckedTextView[@text='${TASK_NAME}']
    Click Element    //android.widget.CheckedTextView[@text='${TASK_NAME}']

Input Event Hint
    [Arguments]    ${INPUT_TEXT}
    Wait Until Page Contains Element    ${HINT_EDIT_TEXT}
    Input Text    ${HINT_EDIT_TEXT}    ${INPUT_TEXT}

Click Event
    [Arguments]    ${EXPECTED_EVENT_XPATH}
    Wait Until Page Contains Element    ${EXPECTED_EVENT_XPATH}
    Click Element    ${EXPECTED_EVENT_XPATH}

Long Press Event
    [Arguments]    ${EXPECTED_EVENT_XPATH}
    Wait Until Page Contains Element    ${EXPECTED_EVENT_XPATH}
    Long Press    ${EXPECTED_EVENT_XPATH}

Click Save Changes Button
    Wait Until Page Contains Element    ${SAVE_CHANGES_BUTTON}
    Click Element    ${SAVE_CHANGES_BUTTON}

Click Delete
    Wait Until Page Contains Element    ${DELETE_VIEW}
    Click Element    ${DELETE_VIEW}

Delete Event
    [Arguments]    ${EVENT_XPATH}
    Long Press Event    ${EVENT_XPATH}
    Click Delete
    Click OK Button

Delete First Event
    Delete Event    ${FIRST_EVENT_XPATH}

Check First Event Detail
    [Arguments]    ${EXPECTED_DATE}    ${EXPECTED_TIME}    ${EXPECTED_TYPE}    ${EXPECTED_TASK}=
    Wait Until Page Contains Element    ${FIRST_EVENT_DATE_VIEW}
    Element Text Should Be    ${FIRST_EVENT_DATE_VIEW}    ${EXPECTED_DATE}
    Wait Until Page Contains Element    ${FIRST_EVENT_TIME_VIEW}
    Element Text Should Be    ${FIRST_EVENT_TIME_VIEW}    ${EXPECTED_TIME}
    Wait Until Page Contains Element    ${FIRST_EVENT_TYPE_VIEW}
    Element Text Should Be    ${FIRST_EVENT_TYPE_VIEW}    ${EXPECTED_TYPE}
    Wait Until Page Contains Element    ${FIRST_EVENT_TASK_VIEW}
    Element Text Should Be    ${FIRST_EVENT_TASK_VIEW}    ${EXPECTED_TASK}

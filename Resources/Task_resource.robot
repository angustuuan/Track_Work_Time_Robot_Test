*** Setting ***
Library    AppiumLibrary

*** Variables ***
#*** Enter And Exit XPATH ***
${EDIT_TASKS_VIEW}    //android.widget.CheckedTextView[@text='Edit Tasks']
${NAVIGATE_UP_BUTTON}    //android.widget.ImageButton[@content-desc='Navigate up']

#*** Button XPATH ***
${MORE_OPTIONS_VIEW}    //android.widget.ImageView[@content-desc='More options']
${NEW_TASK_VIEW}    //android.widget.TextView[@text='New Task']

${OK_BUTTON}    //android.widget.Button[@text='OK']
${CANCEL_BUTTON}    //android.widget.Button[@text='CANCEL']

${RENAME_TASK_VIEW}    //android.widget.TextView[@text='Rename Task']
${TOGGLE_DEFAULT_VIEW}    //android.widget.TextView[@text='Toggle Default']
${TOGGLE_ACTIVATION_STATE_VIEW}    //android.widget.TextView[@text='Toggle Activation State']
${DELETE_TASK_VIEW}    //android.widget.TextView[@text='Delete Task']

#*** Text Pannel XPATH ***
${EDIT_TEXT_PANNEL}    //android.widget.EditText

*** Keywords ***
Enter Edit Tasks Page
    Wait Until Page Contains Element    ${EDIT_TASKS_VIEW}
    Click Element    ${EDIT_TASKS_VIEW}

Back To Main Page
    Wait Until Page Contains Element    ${NAVIGATE_UP_BUTTON}
    Click Element    ${NAVIGATE_UP_BUTTON}

Select New Task
    Wait Until Page Contains Element    ${MORE_OPTIONS_VIEW}
    Click Element    ${MORE_OPTIONS_VIEW}
    Wait Until Page Contains Element    ${NEW_TASK_VIEW}
    Click Element    ${NEW_TASK_VIEW}

Input Task Name
    [Arguments]    ${INPUT_TEXT}
    Wait Until Page Contains Element    ${EDIT_TEXT_PANNEL}
    Input Text    ${EDIT_TEXT_PANNEL}    ${INPUT_TEXT}

Clear Input Task Name
    Wait Until Page Contains Element    ${EDIT_TEXT_PANNEL}
    Clear Text    ${EDIT_TEXT_PANNEL}

Click OK Button
    Wait Until Page Contains Element    ${OK_BUTTON}
    Click Element    ${OK_BUTTON}

Click CANCEL Button
    Wait Until Page Contains Element    ${CANCEL_BUTTON}
    Click Element    ${CANCEL_BUTTON}

Click Task
    [Arguments]    ${EXPECTED_TASK_XPATH}
    Wait Until Page Contains Element    ${EXPECTED_TASK_XPATH}
    Click Element    ${EXPECTED_TASK_XPATH}

Click Rename Task
    Wait Until Page Contains Element    ${RENAME_TASK_VIEW}
    Click Element    ${RENAME_TASK_VIEW}

Click Toggle Default
    Wait Until Page Contains Element    ${TOGGLE_DEFAULT_VIEW}
    Click Element    ${TOGGLE_DEFAULT_VIEW}

Click Toggle Activation State
    Wait Until Page Contains Element    ${TOGGLE_ACTIVATION_STATE_VIEW}
    Click Element    ${TOGGLE_ACTIVATION_STATE_VIEW}

Click Delete Task
    Wait Until Page Contains Element    ${DELETE_TASK_VIEW}
    Click Element    ${DELETE_TASK_VIEW}

Create Task
    [Arguments]    ${TASK_NAME}
    Select New Task
    Input Task Name    ${TASK_NAME}
    Click OK Button
    Wait Until Page Contains Element    //android.widget.TextView[@text='${TASK_NAME}']
    Page Should Contain Element    //android.widget.TextView[@text='${TASK_NAME}']

Delete Task
    [Arguments]    ${TASK_NAME}
    Click Task    //android.widget.TextView[@text='${TASK_NAME}']
    Click Delete Task
    Click OK Button
    Wait Until Page Does Not Contain Element    //android.widget.TextView[@text='${TASK_NAME}']
    Page Should Not Contain Element    //android.widget.TextView[@text='${TASK_NAME}']

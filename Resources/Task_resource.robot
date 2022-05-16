*** Setting ***
Library    AppiumLibrary

*** Variables ***
#*** Enter Edit Tasks XPATH ***
${EDIT_TASKS_VIEW}    //android.widget.CheckedTextView[@text='Edit Tasks']

#*** Edit Tasks Button XPATH ***
${MORE_OPTIONS_VIEW}    //android.widget.ImageView[@content-desc='More options']
${NEW_TASK_VIEW}    //android.widget.TextView[@text='New Task']
${DELETE_TASK_VIEW}    //android.widget.TextView[@text='Delete Task']
${OK_BUTTON}    //android.widget.Button[@text='OK']
${CANCEL_BUTTON}    //android.widget.Button[@text='CANCEL']

#*** Edit Tasks Text Pannel XPATH ***
${EDIT_TEXT_PANNEL}    //android.widget.EditText

*** Keywords ***
Enter Edit Tasks Page
    Wait Until Page Contains Element    ${EDIT_TASKS_VIEW}
    Click Element    ${EDIT_TASKS_VIEW}

Select New Task
    Wait Until Page Contains Element    ${MORE_OPTIONS_VIEW}
    Click Element    ${MORE_OPTIONS_VIEW}
    Wait Until Page Contains Element    ${NEW_TASK_VIEW}
    Click Element    ${NEW_TASK_VIEW}

Enter Task Name
    [Arguments]    ${INPUT_TEXT}
    Wait Until Page Contains Element    ${EDIT_TEXT_PANNEL}
    Input Text    ${EDIT_TEXT_PANNEL}    ${INPUT_TEXT}

Click OK Button
    Click Element    ${OK_BUTTON}

Verify Added Task Show In Edit Tasks Page
    [Arguments]    ${EXPECTED_TASK_XPATH}
    Wait Until Page Contains Element    ${EXPECTED_TASK_XPATH}

Delete Task
    [Arguments]    ${EXPECTED_TASK_XPATH}
    Click Element    ${EXPECTED_TASK_XPATH}
    Wait Until Page Contains Element    ${DELETE_TASK_VIEW}
    Click Element    ${DELETE_TASK_VIEW}
    Wait Until Page Contains Element    ${OK_BUTTON}
    Click Element    ${OK_BUTTON}
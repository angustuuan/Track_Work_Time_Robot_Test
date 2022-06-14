*** Setting ***
Library    AppiumLibrary
Library    String
Library    Collections

*** Variables ***
#*** Appium Settings ***
${APPIUM_URL}    http://localhost:4723/wd/hub

#*** Device Settings ***
${PLATFORM_NAME}    Android
${DEVICE_NAME}    emulator-5554

#*** App Settings ***
${APP_PACKAGE}    org.zephyrsoft.trackworktime
${APP_ACTIVITY}    org.zephyrsoft.trackworktime.WorkTimeTrackerActivity

#*** Automation Settings ***
${AUTOMATION_NAME}    Uiautomator2

#*** Permission Button XPATH ***
${NOT_NOW_STORAGE_PERMISSION_BUTTON}    //android.widget.Button[@text='NOT NOW']
${NO_BACKUP_BUTTON}    //android.widget.Button[@text='NO']

#*** Navigation Drawer XPATH ***
${NAVIGATION_DRAWER_BUTTON}    //android.widget.ImageButton[@content-desc='Open navigation drawer']

*** Keywords ***
Open TrackWorkTime Without Allow Permission
    Open Application    ${APPIUM_URL}    platformName=${PLATFORM_NAME}    deviceName=${DEVICE_NAME}   appPackage=${APP_PACKAGE}    appActivity=${APP_ACTIVITY}    automationName=${AUTOMATION_NAME}
    Wait Until Page Contains Element    ${NOT_NOW_STORAGE_PERMISSION_BUTTON}
    Click Element    ${NOT_NOW_STORAGE_PERMISSION_BUTTON}
    Wait Until Page Contains Element    ${NO_BACKUP_BUTTON}
    Click Element    ${NO_BACKUP_BUTTON}

Open Navigation Drawer
    Wait Until Page Contains Element    ${NAVIGATION_DRAWER_BUTTON}
    Click Element    ${NAVIGATION_DRAWER_BUTTON}

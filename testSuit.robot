*** Settings ***
Library           RequestsLibrary
Resource          apikeyword.txt
Resource          guikeyword.txt
Library           Collections
Library           String
Library           Selenium2Library

*** Variables ***
${guiurl}         http://www.baidu.com
${apiurl}         http://httpbin.org

*** Test Cases ***
apiDemo
    [Tags]    api
    ${args}    带参数的GET请求    ${apiurl}    /get    a=1&b=1    200
    log    ${args}
    ${res}    POST请求    ${apiurl}    /post    ${args}    200
    log    ${res}

guiDemo
    [Tags]    gui
    @{var}    set variable    chrome    ff    #ie
    FOR    ${browser}    IN    @{var}
        log    ${browser}
        Open Browser    ${guiurl}    browser=${browser}
        Selenium2Library.Input Text    id=kw    devops
        Selenium2Library.Click Button    id=su
        Sleep    5s
        Selenium2Library.Close All Browsers
        Sleep    3s
    END
    #androidDemo
    #    [Tags]    and
    #    Open Application    http://localhost:4723/wd/hub    platformName=Android    platformVersion=5.1.1    deviceName=emulator-5554    #appPackage=com.android.settings    appActivity=.Settings
    #    AppiumLibrary.Click Element    name=流量使用情况
    #    AppiumLibrary.Click Element    name=关闭
    #    AppiumLibrary.Element Attribute Should Match    name=开启    checked    true
    #    #AppiumLibrary.Swipe
    #    Sleep    5s
    #    Close All Applications

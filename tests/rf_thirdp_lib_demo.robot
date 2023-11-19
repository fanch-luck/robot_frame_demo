*** Settings ***
Library           SeleniumLibrary

*** Variables ***
${搜索关键词}          robotframework

*** Test Cases ***
test_thirdp_lib
    [Tags]    thirdparty lib    登录测试
    [Setup]    open browser    https://www.baidu.com    firefox
    [Timeout]    30 seconds
    log    开始测试
    sleep    2s
    input text    id:kw    ${搜索关键词}    #输入查询关键词
    ${lengh} =    Get Length    ${搜索关键词}    #检查计数
    log    ${lengh}
    sleep    2s
    click button    id:su    #点击百度一下
    sleep    2s
    log    结束测试
    [Teardown]    close browser    #关闭浏览器

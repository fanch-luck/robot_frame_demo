*** Settings ***
Library           resources/DemoLibrary.py
Library           resources/DemoFuncLibrary.py

*** Variables ***

*** Test Cases ***
test_self_lib
    [Documentation]    test for my demos, files and settings
    [Tags]    自定义库
    my keyword    123    abc    name=111    pass=222    # demo kew word
    log info    a info line    # log info
    log error    a error line    # log error

*** Settings ***
Metadata          meta    data    # Metadata
Metadata          robot    framework    # RobotFramework
Library           OperatingSystem
Library           Collections
Library           Dialogs
Library           Screenshot
Variables         data/PythonVariables.py

*** Variables ***
${str_variable}    robotframework
@{list_variable}    robot    frame    work    new bee
&{dict_variable}    name=user name    password=user password

*** Test Cases ***
test_builtin_lib
    [Documentation]    this test is a RF demo
    [Tags]    builtin lib    demo
    [Setup]    log    开始测试
    [Timeout]    10 minutes    # 如果10分钟内未执行完毕，则超时
    Log    字符串参数：${str_variable}
    Log    列表参数：@{list_variable}
    Log    循环打印列表参数
    Log List    @{list_variable}
    Log    字典参数：&{dict_variable}
    Log    循环打印字典参数
    Log Dict    &{dict_variable}
    Log    python文件内参数
    Log    标量：${py_scalar}
    Log    标量：${py_scalar2}
    Log Many    @{py_list}
    Log Many    &{py_dict}
    Log    打印类属性
    Log    标量：${StudentA.name}
    Log    标量：${StudentA.age}
    Log Many    列表：@{StudentA.subjects}
    Log Many    字典：&{StudentA.info}
    Log    打印动态变量
    Log Many    ${studentB}
        ${first}    Catenate    SEPARATOR=\n    Not in second    same    differs    same
        ${second}    Catenate    SEPARATOR=\n    same    Differs2    same    Not in first
        Should Not Be Equal    ${first}    ${second}
    Log Variables    # 打印范围内所有变量
    ${first_num} =    Convert To Integer    5
    Should Be True    $first_num < 6    # 注意5的类型
    Log    Collection库：list、dict处理    # 注意变量引用的方法
    Log Many    ${list_variable}
    ${list_variable_copy} =    Copy List    ${list_variable}
    Set List Value    ${list_variable_copy}    0    robot-1
    Log Many    ${list_variable}
    Log Many    ${list_variable_copy}
    Log    Dialogs库：用户交互
    ${user_selected_value}=    Get Selection From User    Please select value    @{list_variable}
    Log    ${user_selected_value}
    Log    Screenshot库：截图
    Set Screenshot Directory    ${OUTPUT_DIR}
    Take Screenshot    name=123.png
    #    ${lengh} =    Get Length    robotframework    #检查计数
    #    log    ${lengh}
    #    fail    *HTML*<b>Test not ready</b>    #测试关键词fail
    [Teardown]    log    结束测试

*** Keywords ***
Log List
    [Arguments]    @{_list}
    Log    打印列表
    FOR    ${_item}    IN    @{_list}
        Log    ${_item}
    END

Log Dict
    [Arguments]    &{_dict}
    Log    打印字典
    FOR    ${_key}    ${_value}    IN    &{_dict}
        Log    ${_key}=${_value}
    END

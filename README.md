# robot_frame_demo
robot framework是一个软件测试框架，它将常用的软件测试操作封装为“关键字”库（它的第三方库还将Selenium、requests、Playwright也进行了类似的封装），驱动测试
### 项目结构
*    一种包含tests/, resources/ 和 data/ 文件夹的项目结构:  

A project structure for a more complex project with a more test cases and keywords.  
Test Suites are organized in subfolders in the tests/ folder. Keywords, variables and python libraries are organized in subfolders in the resources/ folder. Test Data files - like Python or Yaml Variable files - are organized in subfolders in the data/ folder.  
The project root folder contains the .gitlab-ci.yml file for CI/CD, the .gitignore file for git, the README.md file for documentation and the requirements.txt file for dependencies.  
my_project  
├── tests  
│   ├── authentication  
│   │   ├── login.robot  
│   │   ├── ...  
│   │  
│   ├── master-data  
│   │   ├── customers.robot  
│   │   ├── products.robot  
│   │   ├── ...  
│   │  
│   ├── order  
│   │   ├── order_creation.robot  
│   │   ├── order_processing.robot  
│   │   ├── ...  
│     
├── resources  
│   ├── common.resource  
│   ├── search.resource  
│   ├── master-data  
│   │   ├── customers.resource  
│   │   ├── products.resource  
│   │   ├── ...  
│   │  
│   ├── ...  
│  
├── data  
│   ├── master-data  
│   │   ├── customers.py  
│   │   ├── products.py  
│   │   ├── ...  
│   │  
│   ├── order  
│   │   ├── order_creation.yaml  
│   │   ├── order_processing.yaml  
│   │   ├── ...  
│  
├── .gitlab-ci.yml  
├── .gitignore  
├── README.md  
├── requirements.txt  
  
The tests/authentication/login.robot file looks like this:  
*** Settings ***  
Resource  resources/common.resource  
Resource  resources/search.resource  
Resource  resources/master-data/customers.resource  
Variables data/master-data/customers.py  
...
### 运行项目
#### 命令行运行
运行时添加特定路径到pythonpath:  
```shell
$ robot --pythonpath . tests`  # 运行整个测试
$ robot --pythonpath . tests\rf_first_project.robot  # 运行指定的Suite
```  
或者在当前目录运行
```shell
$ robot tests.robot  
$ robot --variable BROWSER:chrome --outputdir results tests.robot  # 运行时指定参数
```  
#### 脚本中运行
```python
# run_robot.py
from robot import run
run('tests.robot', variable=['BROWSER:chrome'], outputdir='results')  
```
#### 运行前变更测试
也可以可以使用prerunmodifier，在测试执行前，对测试进行批量修改  
```shell
$ robot --prerunmodifier CopyTest.py tests
```  

以下展示如何复制和修改测试套件中的测试  
```python
# CopyTest.py  
from robot.api import SuiteVisitor
class CopyTest(SuiteVisitor):
    def start_suite(self, suite):
        """Copy and modify tests in the test suite."""
        for test in suite.tests:
            if "copy" not in test.tags:
                test_case = suite.tests.append(test.copy())
                test_case.tags.add("copy")
                test_case.name = f"{test_case.name} (copy)"
```
#### 运行时执行任务
可以使用listener，在测试执行期间，执行监听和其他任务  
`$ robot --listener path/to/listener.py tests`  
以下展示如何监听测试并执行操纵
```python
# listener.py
"""Listener that stops execution if a test fails."""
ROBOT_LISTENER_API_VERSION = 3
def end_test(data, result):
    if not result.passed:
        print('Test "%s" failed: %s' % (result.name, result.message))
        input('Press enter to continue.')
```
### Robot Framework API  
Access and modify all kinds of Robot Framework objects , e.g.  访问和修改所有类型的RF对象  
*    Execution Results  测试执行结果  
*    Test Suites  测试套件  
*    Parsers  解析  
*    Logger  日志记录  
*    Result Writer  结果写入  
*    ...  

Check out the Public API and Entry Points for more information.  
You can use the API to build your own tools or integrate Robot Framework with other tools.  
Examples are  
*    Integrating Robot Framework with (Test Management) Tools like Jira or TestRail  
*    Building your own Test Runner in Python  
*    Create tools for analyzing and refactoring Robot Framework Tests (like robotidy or robocop)  
*    Create UIs for Robot Framework  
*    Create Tools to distribute Robot Framework Tests  
*    Create Web Services for Robot Framework  
*    ...  

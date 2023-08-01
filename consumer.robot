*** Settings ***
Resource    resources/main.resource

*** Variables ***


*** Tasks ***
Retrieve Database Records
    [Documentation]   Task responsible for opening the browser to the portal
    ${status}    ${records_return}    Run Keyword And Ignore Error    Recover Pending
    IF    "${status}" == "PASS" and ${records_return[0]}
        Log    Success    level=INFO
        Set Suite Variable    ${records}    ${records_return[1]}
        Set Next Task    Open Browser Generic
    ELSE
        Log    Error open Browser    level=ERROR
        Set Next Task    End Execution
    END

Open Browser Generic
    [Documentation]   Task responsible for opening the browser to the portal
    ${status}    ${browser_return}    Run Keyword And Ignore Error    Open Browser Used   ${records['link']}
    IF    "${status}" == "PASS"
        Log    Success    level=INFO
        Set Next Task    Start Extracting Events
    ELSE
        Log    Error open Browser    level=ERROR
    END

Start Extracting Events
    [Documentation]    Task responsible for extracting information from each available event
    ${status}    ${extrating_return}    Run Keyword And Ignore Error    Extracting Events
    IF    "${status}" == "PASS"
        Log    Sucesso    level=INFO
        Set Suite Variable    ${extract_list}    ${extrating_return}
        Set Next Task    Save Records In The Database
    ELSE
        Log    Error open Browser    level=ERROR
    END

Save Records In The Database
    [Documentation]    task responsible for saving records in the database
    ${status}    ${save_records_return}    Run Keyword And Ignore Error    Save Records    ${extract_list}
    IF    "${status}" == "PASS"
        Log    Sucesso    level=INFO
        Set Next Task    End Execution
    ELSE
        Log    Error open Browser    level=ERROR
    END

End Execution
    [Documentation]    Task responsible for closing browser
    Close All Browsers
    Log     browser closed    level=INFO
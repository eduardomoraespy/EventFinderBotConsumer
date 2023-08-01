*** Settings ***
Resource    ${ROOT}/resources/main.resource

*** Variables ***
${status_keyword}

*** Keywords ***
Open Browser Used
    [Documentation]    keyword responsible for opening browser and accessing the defined url
    [Arguments]    ${url}
    ${status}    ${browser_return}    Run Keyword And Ignore Error    Open Available Browser    ${url}    maximized=${TRUE}
    ${element_visible}    Wait Until Element Is Visible    ${eventbrite.btn_search}    timeout=20s
    log    ${element_visible}
    IF    "${status}" == "PASS"
        Set Suite Variable    ${return_bool}    ${TRUE}
    ELSE
        Set Suite Variable    ${return_bool}    ${FALSE}
    END

    RETURN    ${return_bool}

Get Pagination Value
    [Documentation]    keyword responsible for getting the pagination number
    Wait Until Element Is Visible    ${eventbrite.paginator}    timeout=20s
    ${range_page}    Get Text    ${eventbrite.paginator}
    ${clean_range}    Set Variable    ${range_page.split()}
    ${current_page}    Set Variable    ${clean_range[0]}
    ${last_page}    Set Variable    ${clean_range[2]}
    RETURN    ${current_page}    ${last_page}

Extracting Events
    [Documentation]    keyword responsible for extracting information from each available event
    ${pagination_values}    Get Pagination Value
    ${current_page}    Convert To Integer    ${pagination_values[0]}
    ${last_page}    Convert To Integer    ${pagination_values[1]}
    ${extract_list}    Create List
    
    FOR    ${iterator}   IN RANGE    ${current_page}    ${last_page+1}
        Wait Until Element Is Visible    ${eventbrite.elements_li}    timeout=20s
        ${quantity_elements}    Get Element Count    ${eventbrite.elements_li}
        
        FOR    ${iterator_elements}   IN RANGE    ${1}    ${quantity_elements+1}
            
            ${event_link}    Format String    ${eventbrite.event_link}    variable_value=${iterator_elements}
            Wait Until Element Is Visible    ${event_link}    timeout=20s
            ${value_link}    Get Element Attribute    ${event_link}    href
            
            ${event_title}    Format String    ${eventbrite.event_title}    variable_value=${iterator_elements}
            Wait Until Element Is Visible    ${event_title}    timeout=20s
            ${value_title}    Get Text    ${event_title}

            ${extraction_dictionary}    Create Dictionary    event_link=${value_link}    event_title=${value_title}
            
            Append To List    ${extract_list}    ${extraction_dictionary}
        END
        
        IF    ${iterator} != ${last_page}
            Wait Until Element Is Visible    ${eventbrite.next_page}    timeout=20s
            Click Button    ${eventbrite.next_page}
        END
    END

    RETURN    ${extract_list}
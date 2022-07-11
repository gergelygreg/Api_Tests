*** Settings ***
Resource    ../../../../testdata/variables/imports.resource
Resource  ../../../../keywords/imports.resource

Library    RequestsLibrary

Test Template    Custom Test Template

*** Test Cases ***                                       USERNAME       PASSWORD
Verify Login With Wrong Returns 401                      admin          wrongPass

Verify Login With Wrong User Returns 401                 guest          masterPass

Verify Login With Empty Data Returns 401                 ${Empty}       ${Empty}

Verify Login With Wrong User And Password Return 401     guest          wrongPass

#Verify Login With Wrong Returns 401
    #Log To Console    \nSending Request To ${GLOBAL_ENDPOINT_LOGIN}\n
    #&{jsonBody}  Create Dictionary  username=admin  password=wrongPass
    #${response}  POST  url=${GLOBAL_ENDPOINT_LOGIN}  json=${jsonBody}  expected_status=401
   # Validate Json Schema    input_json=${response.json()}    reference_schema_path=${GLOBAL_SCHEMA_ERROR}

#Verify Login With Wrong User Returns 401
   # Log To Console    \nSending Request To ${GLOBAL_ENDPOINT_LOGIN}\n
   # &{jsonBody}  Create Dictionary  username=admin  password=masterPass
   # ${response}  POST  url=${GLOBAL_ENDPOINT_LOGIN}  json=${jsonBody}  expected_status=401
   # Validate Json Schema    input_json=${response.json()}    reference_schema_path=${GLOBAL_SCHEMA_ERROR}



*** Keywords ***
Custom Test Template
    [Arguments]    ${username}    ${password}
    Log To Console    \nSending Request To ${GLOBAL_ENDPOINT_LOGIN}\n
    &{jsonBody}  Create Dictionary  username=${username}  password=${password}
    ${response}  POST  url=${GLOBAL_ENDPOINT_LOGIN}  json=${jsonBody}  expected_status=401
    Validate Schema    inputJson=${response.json()}    referenceSchemaPath=${GLOBAL_SCHEMA_ERROR}

#Custom Test Template
    #[Arguments]    ${username}    ${password}
   # Log To Console    \nSending Request To ${GLOBAL_ENDPOINT_LOGIN}\n
   # &{jsonBody}  Create Dictionary  username=${username}  password=${password}
   # ${response}  POST  url=${GLOBAL_ENDPOINT_LOGIN}  json=${jsonBody}  expected_status=401
    #Validate Json Schema    input_json=${response.json()}    reference_schema_path=${GLOBAL_SCHEMA_ERROR}
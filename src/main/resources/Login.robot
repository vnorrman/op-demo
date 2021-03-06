*** Settings ***
Documentation  Robot Framework demo of simple web UI testing with Selenium2Library

Library  Selenium2Library  15s

Test Timeout  2 minutes
Suite Teardown  Close All Browsers

*** Variables ***
${REMOTE_URL}
${URL}  http://www.op.fi
${BROWSER}  chrome

*** Test Cases ***
Login to OP online bank as a test user
  Given user opens a browser and goes to address "${URL}"
  When user types user id "123456"
  and user types password "7890"
  and User presses Yes
  and system prompts for a key
  and user types key "12345"
  and user presses Jatka
  Then online bank will open
  and user logs out

*** Keywords ***

User Opens a Browser and goes to address "${url}"
    ${remote}=  Get Variable Value  ${REMOTE_URL}  None
    Run Keyword If  '${remote}'==''  Open Browser  ${url}  ${BROWSER}
    Run Keyword Unless  '${remote}'==''  Open Browser  ${url}  ${BROWSER}    None  ${REMOTE_URL}
    
User types user id "${id}" 
  Set Selenium Speed  10s
  Wait Until Page Contains Element  kayttajatunnus
  Input Text  kayttajatunnus  ${id}  

User types password "${password}"
  Wait Until Page Contains Element  salasana
  Input Text  salasana  ${password}  

User presses Yes
  Click Element  xpath=//input[@alt="OK"]  

System prompts for a key
  Wait Until Page Contains  Kirjoita avainluku

User types key "${key}"
  Wait Until Page Contains Element  xpath=//input[@name="avainluku"]
  Input Text  xpath=//input[@name="avainluku"]  1234

User presses Jatka
  Click Element  xpath=//input[@name="act_ok"]

Online bank will open
  Wait Until Page Contains  Käytit verkkopalvelutunnuksiasi edellisen kerran
  
User logs out
  Click link  lopetuslinkki
  Wait Until Page Contains  Olet kirjautunut ulos OP-verkkopalvelusta
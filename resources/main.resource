*** Settings ***
Documentation    Docum

Library    String
Library    DateTime
Library    OperatingSystem
Library    Collections
Library    RPA.Tasks
Library    RPA.Browser.Selenium
Variables    ${ROOT}/core/settings.py
Resource    ${ROOT}/resources/locators.resource
Resource    ${ROOT}/keywords.robot
Library    ${ROOT}/utils/utils.py

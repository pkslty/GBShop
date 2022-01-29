//
//  GBShopUITests.swift
//  GBShopUITests
//
//  Created by Denis Kuzmin on 26.11.2021.
//

import XCTest

class GBShopUITests: XCTestCase {
    let app = XCUIApplication()
    
    override func setUpWithError() throws {
        setupSnapshot(app)
        app.launch()
        continueAfterFailure = false
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testLoginLogoutSuccess() throws {
        app.tabBars["Tab Bar"].buttons["User"].tap()
        let scrollViewsQuery = app.scrollViews
        let elementsQuery = scrollViewsQuery.otherElements
        let userNameField = elementsQuery.textFields["Username"]
        userNameField.tap()
        userNameField.typeText("12345678")
        let passwordField = elementsQuery.secureTextFields["Password"]
        passwordField.tap()
        passwordField.typeText("12345")
        
        elementsQuery/*@START_MENU_TOKEN@*/.staticTexts["Sign In"]/*[[".buttons[\"Sign In\"].staticTexts[\"Sign In\"]",".staticTexts[\"Sign In\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        let nameField = scrollViewsQuery.otherElements.containing(.button, identifier:"Log Out").children(matching: .other).element.children(matching: .other).element.children(matching: .other).element(boundBy: 1).children(matching: .textField).element
        XCTAssertNotNil(nameField.value)
        let name = nameField.value as! String
        XCTAssertEqual(name, "Jane Elisabeth Doe")
        
        let logoutButton = scrollViewsQuery.otherElements/*@START_MENU_TOKEN@*/.staticTexts["Log Out"]/*[[".buttons[\"Log Out\"].staticTexts[\"Log Out\"]",".staticTexts[\"Log Out\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        logoutButton.tap()
        let authorizationLabel = scrollViewsQuery.otherElements.staticTexts["Authorization"]
        XCTAssertNotNil(authorizationLabel.value)
    
    }
    
    func testLoginFail() throws {
        app.tabBars["Tab Bar"].buttons["User"].tap()
        let elementsQuery = app.scrollViews.otherElements
        let userNameField = elementsQuery.textFields["Username"]
        userNameField.tap()
        userNameField.typeText("12345678")
        let passwordField = elementsQuery.secureTextFields["Password"]
        passwordField.tap()
        passwordField.typeText("123")
        elementsQuery.buttons["Sign In"].tap()
        let alert = app.alerts["Error"]
        XCTAssertNotNil(alert)
        alert.scrollViews.otherElements.buttons["Ok"].tap()
                
        
    }
    
    func testGetSnapshots() throws {
        app.tabBars["Tab Bar"].buttons["User"].tap()
        snapshot("LoginScreen")
        let elementsQuery = app.scrollViews.otherElements
        let userNameField = elementsQuery.textFields["Username"]
        userNameField.tap()
        userNameField.typeText("12345678")
        let passwordField = elementsQuery.secureTextFields["Password"]
        passwordField.tap()
        passwordField.typeText("12345")
        elementsQuery.buttons["Sign In"].tap()
        
        app.tabBars["Tab Bar"].buttons["Catalog"].tap()
        app.tables.cells.containing(.staticText, identifier:"Периферия").element.tap()
        //app.navigationBars["Периферия"].buttons["filter"].tap()
        snapshot("CatalogScreen")
        //app.navigationBars["Периферия"].buttons["filter"].tap()
        let tabBar = XCUIApplication().tabBars["Tab Bar"]
        tabBar.buttons["Cart"].tap()
        tabBar.buttons["User"].tap()
        snapshot("UserInfoScreen")
        XCUIApplication().scrollViews.otherElements/*@START_MENU_TOKEN@*/.staticTexts["Log Out"]/*[[".buttons[\"Log Out\"].staticTexts[\"Log Out\"]",".staticTexts[\"Log Out\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        
        
        
                                        
    }
    
    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}

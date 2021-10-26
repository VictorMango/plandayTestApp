//
//  Tests_iOS.swift
//  Tests iOS
//
//  Created by Victor Pedersen on 16/10/2021.
//

import XCTest
import ViewInspector
@testable import plandayapp

extension ArticleView: Identifiable {}

final class ArticleViewTests: XCTestCase {

    override func setUpWithError() throws {
        continueAfterFailure = false
    }
    
    func testStringValue() throws { // 3.
        let view = ArticleView()
        let list = try view.inspect().list()
        try list[2].view(RowArticleView.self).callOnAppear()
    }

    func testToCheckIf() throws {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()
    }
}

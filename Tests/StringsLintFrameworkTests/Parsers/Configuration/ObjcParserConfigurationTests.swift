//
//  ObjcParserConfigurationTests.swift
//  StringsLintFrameworkTests
//
//  Created by Alessandro "Sandro" Calzavara on 05/01/2019.
//

import XCTest
@testable import StringsLintFramework

class ObjcParserConfigurationTests: ConfigurationTestCase {

    func creareConfigFileAsDictionary(with content: String) throws -> Any {
        
        let file = try self.createTempConfigurationFile(with: content)
        
        let yamlContents = try String(contentsOfFile: file, encoding: .utf8)
        let dict = try YamlParser.parse(yamlContents)
        
        return dict as Any
    }
    
    func testImplicitMacros() throws {
        
        let content = """
implicit_macros:
- ABCString
"""
        
        let data = try self.creareConfigFileAsDictionary(with: content)

        var configuration = ObjcParserConfiguration()
        try configuration.apply(data)
        
        XCTAssertEqual(configuration.implicitMacros.count, 2)
        XCTAssertEqual(configuration.implicitMacros, [ "NSLocalizedString", "ABCString" ])
    }
    
    func testExplicitMacros() throws {
        
        let content = """
explicit_macros:
- ABCString
"""
        
        let data = try self.creareConfigFileAsDictionary(with: content)
        
        var configuration = ObjcParserConfiguration()
        try configuration.apply(data)
        
        XCTAssertEqual(configuration.explicitMacros.count, 2)
        XCTAssertEqual(configuration.explicitMacros, [ "NSLocalizedStringFromTable", "ABCString" ])
    }

}

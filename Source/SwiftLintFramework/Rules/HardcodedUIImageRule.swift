//
//  HardcodedUIImageRule.swift
//  SwiftLint
//
//  Created by Tayal, Rishabh on 5/3/17.
//  Copyright © 2017 Realm. All rights reserved.
//

import Foundation
import SourceKittenFramework

public struct HardcodedUIImageRule: ConfigurationProviderRule {
    
    public var configuration = SeverityConfiguration(.warning)
    
    public init() {}
    
    public static let description = RuleDescription(
        identifier: "hardcoded_uiimage",
        name: "Hardcoded UIImage Constructor",
        description: "If using R.swift, enable this rule to check for hard coded UIImage usage.",
        kind: .idiomatic,
        nonTriggeringExamples: [
            "R.image"
        ],
        triggeringExamples: ["", ".init"].flatMap { (method: String) -> [String] in
            ["UI", "NS"].flatMap { (prefix: String) -> [String] in
                [
                    "let image = ↓\(prefix)Image\(method)(named: \"foo\")",
                ]
            }
        }
    )
    
    public func validate(file: File) -> [StyleViolation] {
        let constructors = ["UIImage"]
        
        let pattern = "\\b(" + constructors.joined(separator: "|") + ")\\b"
        
        return file.match(pattern: pattern, with: [.identifier]).map {
            StyleViolation(ruleDescription: type(of: self).description,
                           severity: configuration.severity,
                           location: Location(file: file, characterOffset: $0.location))
        }
    }
    
//    public func correct(file: File) -> [Correction] {
//        let twoVarsOrNum = RegexHelpers.twoVariableOrNumber
//        let patterns = [
//            "CGPointMake\\(\\s*\(twoVarsOrNum)\\s*\\)": "CGPoint(x: $1, y: $2)",
//            "CGSizeMake\\(\\s*\(twoVarsOrNum)\\s*\\)": "CGSize(width: $1, height: $2)",
//            "CGRectMake\\(\\s*\(twoVarsOrNum)\\s*,\\s*\(twoVarsOrNum)\\s*\\)":
//            "CGRect(x: $1, y: $2, width: $3, height: $4)",
//            "CGVectorMake\\(\\s*\(twoVarsOrNum)\\s*\\)": "CGVector(dx: $1, dy: $2)",
//            "NSMakePoint\\(\\s*\(twoVarsOrNum)\\s*\\)": "NSPoint(x: $1, y: $2)",
//            "NSMakeSize\\(\\s*\(twoVarsOrNum)\\s*\\)": "NSSize(width: $1, height: $2)",
//            "NSMakeRect\\(\\s*\(twoVarsOrNum)\\s*,\\s*\(twoVarsOrNum)\\s*\\)":
//            "NSRect(x: $1, y: $2, width: $3, height: $4)",
//            "NSMakeRange\\(\\s*\(twoVarsOrNum)\\s*\\)": "NSRange(location: $1, length: $2)",
//            "UIEdgeInsetsMake\\(\\s*\(twoVarsOrNum)\\s*,\\s*\(twoVarsOrNum)\\s*\\)":
//            "UIEdgeInsets(top: $1, left: $2, bottom: $3, right: $4)",
//            "NSEdgeInsetsMake\\(\\s*\(twoVarsOrNum)\\s*,\\s*\(twoVarsOrNum)\\s*\\)":
//            "NSEdgeInsets(top: $1, left: $2, bottom: $3, right: $4)"
//        ]
//        return file.correct(legacyRule: self, patterns: patterns)
//    }
}

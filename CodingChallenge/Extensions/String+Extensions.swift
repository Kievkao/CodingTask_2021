//
//  String+Extensions.swift
//  CodingChallenge
//
//  Created by Andrii Kravchenko on 28.01.21.
//

import UIKit

extension String {
    func underscored() -> NSAttributedString {
        NSAttributedString(string: self, attributes: [.underlineStyle: NSUnderlineStyle.single.rawValue])
    }

    func asPhone() -> String {
        if !self.hasPrefix("tel://") {
            return "tel://" + self.components(separatedBy: CharacterSet.decimalDigits.inverted).joined()
        } else {
            return self
        }
    }
}

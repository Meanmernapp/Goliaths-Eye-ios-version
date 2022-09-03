//
//  Array.swift
//  Waste2x
//
//  Created by MAC on 03/06/2021.
//  Copyright © 2021 Haider Awan. All rights reserved.
//

import Foundation
import  UIKit

extension Array where Element: Equatable {
    func indexes(of element: Element) -> [Int] {
        return self.enumerated().filter({ element == $0.element }).map({ $0.offset })
    }
}

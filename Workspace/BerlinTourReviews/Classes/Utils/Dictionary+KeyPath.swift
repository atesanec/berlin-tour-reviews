//
//  Dictionary+KeyPath.swift
//  BerlinTourReviews
//
//  Created by VI_Business on 25/08/2018.
//  Copyright © 2018 supercorp. All rights reserved.
//

import Foundation

extension Dictionary {
    func valueFor(keyPath: String) -> Any? {
        let components = keyPath.components(separatedBy: ".")
        if components.isEmpty {
            return self
        }
        
        var result: Any? = self
        for item in components {
            result = (result as? [String: Any])?[item]
            if result == nil {
                return nil
            }
        }
        
        return result
    }
}

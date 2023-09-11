//
//  CGFloat+Extension.swift
//  Testing
//
//  Created by SivA on 9/11/23.
//

import Foundation

extension CGFloat {
    var fraction: String {
        let eps : Double = 1.0E-6
        var x = self
        var a = floor(x)
        var (h1, k1, h, k) = (1, 0, Int(a), 1)

        while x - a > eps * Double(k) * Double(k) {
            x = 1.0/(x - a)
            a = floor(x)
            (h1, k1, h, k) = (h, k, h1 + Int(a) * h, k1 + Int(a) * k)
        }
        return "\(h)/\(k)"
    }
}

//
//  NSData+Hex.swift
//  ShadowVPN
//
//  Created by clowwindy on 8/9/15.
//  Copyright © 2015 clowwindy. All rights reserved.
//

import Foundation

extension Data {
    init(fromHex hexString: String) {
        var bytes: [UInt8] = []
        var temp = ""
        for char in hexString {
            temp.append(char)
            if temp.lengthOfBytes(using: .utf8) == 2 {
                let scanner = Scanner(string: temp)
                var value: CUnsignedInt = 0
                scanner.scanHexInt32(&value)
                bytes.append(UInt8(value))
                temp = ""
            }
        }
        self.init(bytes: bytes)
    }
}

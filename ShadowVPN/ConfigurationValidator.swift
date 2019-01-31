//
//  ConfigurationValidator.swift
//  ShadowVPN
//
//  Created by clowwindy on 8/10/15.
//  Copyright © 2015 clowwindy. All rights reserved.
//

import UIKit

class ConfigurationValidator: NSObject {
    
    // return nil if there's no error
    class func validateIP(ip: String) -> String? {
        let parts = ip.components(separatedBy: ".")
        if parts.count != 4 {
            return "Invalid IP: " + ip
        }
        for part in parts {
            let n = Int(part)
            if n == nil || n! < 0 || n! > 255 {
                return "Invalid IP: " + ip
            }
        }
        return nil
    }
    
    // return nil if there's no error
    class func validate(configuration: [String: Any]) -> String? {
        // 1. server must be not empty
        guard let server = configuration["server"] as? String, server.count > 0 else {
            return "Server must not be empty"
        }
        // 2. port must be int 1, 65535
        guard let portStr = configuration["port"] as? String, portStr.count > 0, let port = Int(portStr) else {
            return "Port must not be empty"
        }
        if port < 1 || port > 65535 {
            return "Port is invalid"
        }
        // 3. password must be not empty
        guard let password = configuration["password"] as? String, password.count > 0 else {
            return "Password must not be empty"
        }
        // 4. usertoken must be empty or hex of 8 bytes
        if let usertoken = configuration["usertoken"] as? String {
            let data = Data(fromHex: usertoken)
            if data.count != 8 && data.count != 0 {
                return "Usertoken must be HEX of 8 bytes (example: 7e335d67f1dc2c01)"
            }
        }
        // 5. ip must be valid IP
        guard let ip = configuration["ip"] as? String, ip.count > 0 else {
            return "IP must not be empty"
        }
        if let result = validateIP(ip: ip) {
            return result
        }
        // 6. subnet must be valid subnet
        guard let subnet = configuration["subnet"] as? String, subnet.count > 0 else {
            return "Subnet must not be empty"
        }
        if let result = validateIP(ip: subnet) {
            return result
        }
        // 7. dns must be comma separated ip addresses
        guard let dns = configuration["dns"] as? String, dns.count > 0 else {
            return "DNS must not be empty"
        }
        let ips = dns.components(separatedBy: ",")
        if ips.count == 0 {
            return "DNS must not be empty"
        }
        for ip in ips {
            if let result = validateIP(ip: ip) {
                return result
            }
        }
        // 8. mtu must be int
        guard let mtuStr = configuration["mtu"] as? String, mtuStr.count > 0, let mtu = Int(mtuStr) else {
            return "MTU must not be empty"
        }
        if mtu < 100 || mtu > 9000 {
            return "MTU is invalid"
        }
        // 9. routes must be empty or chnroutes
        return nil
    }
}

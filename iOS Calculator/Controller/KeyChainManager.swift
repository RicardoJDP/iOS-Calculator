//
//  KeyChainManager.swift
//  iOS Calculator
//
//  Created by RicardoD on 24/9/22.
//

import Foundation

class KeychainManager{
    enum Keychainerror: Error{
        case duplicateEntry
        case itemNotFound
        case unknown(OSStatus)
    }
    
    static func save(
        service: String,
        username: String,
        password: Data
    ) throws {
        print("starting save...")
        //service, account, password, class
        let query: [String: AnyObject] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: service as AnyObject,
            kSecAttrAccount as String: username as AnyObject,
            kSecValueData as String: password as AnyObject,
        ]
        
        let status = SecItemAdd(query as CFDictionary, nil)
        
        guard status != errSecDuplicateItem else{
            throw Keychainerror.duplicateEntry
        }
        
        guard status == errSecSuccess else {
            throw Keychainerror.unknown(status)
        }
        
        print("saved")
    }
    
    static func getPassword(
        service: String,
        username: String//,
        //password: Data
    ) -> Data? {
        print("starting get...")
        //service, account, password, class
        let query: [String: AnyObject] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: service as AnyObject,
            kSecAttrAccount as String: username as AnyObject,
            kSecReturnData as String: kCFBooleanTrue,
            kSecMatchLimit as String: kSecMatchLimitOne
        ]
        
        var result: AnyObject?
        let status = SecItemCopyMatching(query as CFDictionary, &result)
        

        print("Read Status: \(status)")
        
        return result as? Data
    }
    
    static func getUser(
        service: String,
        username: String
    ) -> Data? {
        print("starting get...")
        //service, account, password, class
        let query: [String: AnyObject] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: service as AnyObject,
            kSecAttrAccount as String: username as AnyObject,
            kSecReturnData as String: kCFBooleanTrue,
            kSecMatchLimit as String: kSecMatchLimitOne
        ]
        
        var result: AnyObject?
        let status = SecItemCopyMatching(query as CFDictionary, &result)
        
        print("Read Status: \(status)")
        
        
        return result as? Data
    }
    
    static func getKeyChain(
        service: String,
        username: String,
        password: Data
    ) -> Data?{
        print("starting get...")
        //service, account, password, class
        let query: [String: AnyObject] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: service as AnyObject,
            kSecAttrAccount as String: username as AnyObject,
            kSecValueData as String: password as AnyObject,
            kSecReturnData as String: kCFBooleanTrue,
            kSecMatchLimit as String: kSecMatchLimitOne
        ]
        
        var result: AnyObject?
        let status = SecItemCopyMatching(query as CFDictionary, &result)
        

        print("Read Status: \(status)")
        
        return result as? Data
    }
    
    
    static func updatePassword(
        service: String,
        username: String,
        password: Data
    )throws{
        print("starting update pass or user...")
        
        let query: [String: AnyObject] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: service as AnyObject,
            kSecAttrAccount as String: username as AnyObject,
            //kSecValueData as String: password as AnyObject,
            //kSecReturnData as String: kCFBooleanTrue,
            //kSecMatchLimit as String: kSecMatchLimitOne
        ]
        //print("Semi Update")
        let attributes : [String: AnyObject] = [
            kSecValueData as String: password as AnyObject
        ]
        let status = SecItemUpdate(query as CFDictionary, attributes as CFDictionary)
        
        guard status != errSecItemNotFound else{
            throw Keychainerror.itemNotFound
        }
        
        guard status == errSecSuccess else {
            throw Keychainerror.unknown(status)
        }
        
        print("updated")
    }
    
    static func updateUser(
        service: String,
        oldUsername: String,
        username: String,
        password: Data
    )throws{
        print("starting update credentials...")
        
        let query: [String: AnyObject] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: service as AnyObject,
            kSecAttrAccount as String: oldUsername as AnyObject,
            //kSecValueData as String: password as AnyObject,
            //kSecReturnData as String: kCFBooleanTrue,
            //kSecMatchLimit as String: kSecMatchLimitOne
        ]
        //print("Semi Update")
        let attributes : [String: AnyObject] = [ kSecAttrAccount as String: username as AnyObject
        ]
        let status = SecItemUpdate(query as CFDictionary, attributes as CFDictionary)
        
        guard status != errSecItemNotFound else{
            throw Keychainerror.itemNotFound
        }
        
        guard status == errSecSuccess else {
            throw Keychainerror.unknown(status)
        }
        
        print("updated")
    }
    
    static func updateCredentials(
        service: String,
        oldUsername: String,
        username: String,
        password: Data
    )throws{
        print("starting update credentials...")
        
        let query: [String: AnyObject] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: service as AnyObject,
            kSecAttrAccount as String: oldUsername as AnyObject,
            //kSecValueData as String: password as AnyObject,
            //kSecReturnData as String: kCFBooleanTrue,
            //kSecMatchLimit as String: kSecMatchLimitOne
        ]
        //print("Semi Update")
        let attributes : [String: AnyObject] = [ kSecAttrAccount as String: username as AnyObject,
            kSecValueData as String: password as AnyObject
        ]
        let status = SecItemUpdate(query as CFDictionary, attributes as CFDictionary)
        
        guard status != errSecItemNotFound else{
            throw Keychainerror.itemNotFound
        }
        
        guard status == errSecSuccess else {
            throw Keychainerror.unknown(status)
        }
        
        print("updated")
    }
    
    static func delete(
        service: String,
        username: String
    )throws{
        print("starting deleted...")
        
        let query: [String: AnyObject] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: service as AnyObject,
            kSecAttrAccount as String: username as AnyObject,
            //kSecValueData as String: password as AnyObject,
            //kSecReturnData as String: kCFBooleanTrue,
            //kSecMatchLimit as String: kSecMatchLimitOne
        ]
        //print("Semi Update")
        /*let attributes : [String: AnyObject] = [
            kSecValueData as String: password as AnyObject
        ]*/
        let status = SecItemDelete(query as CFDictionary)
        
        guard status != errSecItemNotFound else{
            throw Keychainerror.itemNotFound
        }
        
        guard status == errSecSuccess else {
            throw Keychainerror.unknown(status)
        }
        
        print("deleted")
    }
}

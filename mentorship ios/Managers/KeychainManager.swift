//
//  KeychainManager.swift
//  Created on 06/06/20.
//  Created for AnitaB.org Mentorship-iOS 
//

import Foundation

struct KeychainManager {
    enum KeychainError: Error {
        case noPassword
        case unexpectedPasswordData
        case unhandledError(status: OSStatus)
    }
    
    static func addToKeychain(username: String, tokenString: String) throws {
        let account = username
        let token = tokenString.data(using: String.Encoding.utf8)!
        let server = baseURL
        let query: [String: Any] = [kSecClass as String: kSecClassInternetPassword,
                                    kSecAttrAccount as String: account,
                                    kSecAttrServer as String: server,
                                    kSecValueData as String: token]
        let status = SecItemAdd(query as CFDictionary, nil)
        guard status == errSecSuccess else {
            //throw KeychainError.unhandledError(status: status)
            do { try replaceKeychainItem(username: username, tokenString: tokenString) } catch { return }
            return
        }
    }
    
    static func replaceKeychainItem(username: String, tokenString: String) throws {
        let server = baseURL
        let query: [String: Any] = [kSecClass as String: kSecClassInternetPassword,
                                    kSecAttrServer as String: server]
        let account = username
        let token = tokenString.data(using: String.Encoding.utf8)!
        let attributes: [String: Any] = [kSecAttrAccount as String: account,
                                         kSecValueData as String: token]
        
        let status = SecItemUpdate(query as CFDictionary, attributes as CFDictionary)
        guard status != errSecItemNotFound else { throw KeychainError.noPassword }
        guard status == errSecSuccess else { throw KeychainError.unhandledError(status: status) }
    }
    
    static func readKeychain() throws -> String {
        let server = baseURL
        let query: [String: Any] = [kSecClass as String: kSecClassInternetPassword,
                                    kSecAttrServer as String: server,
                                    kSecMatchLimit as String: kSecMatchLimitOne,
                                    kSecReturnAttributes as String: true,
                                    kSecReturnData as String: true]
        
        var item: CFTypeRef?
        let status = SecItemCopyMatching(query as CFDictionary, &item)
        guard status != errSecItemNotFound else { throw KeychainError.noPassword }
        guard status == errSecSuccess else { throw KeychainError.unhandledError(status: status) }
        
        guard let existingItem = item as? [String: Any],
            let tokenData = existingItem[kSecValueData as String] as? Data,
            let token = String(data: tokenData, encoding: String.Encoding.utf8),
            let _ = existingItem[kSecAttrAccount as String] as? String
            else {
                throw KeychainError.unexpectedPasswordData
        }
        return token
    }
    
    static func deleteTokenFromKeychain() throws {
        let server = baseURL
        let query: [String: Any] = [kSecClass as String: kSecClassInternetPassword,
        kSecAttrServer as String: server]
        
        let status = SecItemDelete(query as CFDictionary)
        guard status == errSecSuccess || status == errSecItemNotFound else { throw KeychainError.unhandledError(status: status) }
    }
    
}

//objective c code given by apple engineer to fix keychain bug.

/*
func temp() {
    kSecAttrService
    static bool
    SecItemUpdateOrAdd(NSDictionary *query, NSDictionary *update, NSError **error)
    {
        OSStatus saveStatus = SecItemUpdate((CFDictionaryRef)query, (CFDictionaryRef)update);
        
        if (errSecItemNotFound == saveStatus) {
            NSMutableDictionary *add = [query mutableCopy];
            for (id key in update) {
                add[key] = update[key];
            }
            saveStatus = SecItemAdd((CFDictionaryRef)add, NULL);
        }
        if (saveStatus && error) {
            *error = ...
            return false;
        }
        return true;
    }
    NSError *localError = nil;
    NSDictionary *attributes = @{
        (const NSString *)kSecClass:                (const NSString *)kSecClassGenericPassword,
        (const NSString *)kSecAttrAccessGroup:      @"D23532.com.whateverr",
        (const NSString *)kSecAttrService:          @"service",
        (const NSString *)kSecAttrAccount:          @"account",
    };
    NSDictionary *update = @{
        (const NSString *)kSecValueData:            blah.data,
    };
    /* Attempt to store keychain item. */
    if (SecItemUpdateOrAdd(attributes, update, &localError)) {
        ...
        
        
    }
    */

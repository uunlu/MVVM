//
//  Resource.swift
//  MVVMSwiftUI
//
//  Created by Ugur Unlu on 2/10/22.
//

import SwiftUI

enum Resource<T> {
    case pending
    case loading
    case success(T)
    case error(Error)
}

// MARK: - Resource Computer Variables

extension Resource {
    var loading: Bool {
        if case .loading = self {
            return true
        }
        return false
    }
    
    var value: T? {
        if case .success(let value) = self {
            return value
        }
        return nil
    }
    
    var error: Error? {
        if case .error(let error) = self {
            return error
        }
        return nil
    }
    
}

// MARK: - Resource Content

extension Resource {
    func isLoading<Content: View>(@ViewBuilder content: @escaping () -> Content) -> Content? {
        loading ? content() : nil
    }
    
    func hasResource<Content: View>(@ViewBuilder content: @escaping (T) -> Content) -> Content? {
        if let value = value {
            return content(value)
        }
        return nil
    }
    
    func hasError<Content: View>(@ViewBuilder content: @escaping (Error) -> Content) -> Content? {
        if let error = error {
            return content(error)
        }
        return nil
    }
}

// TODO: - What is UI is not SwiftUI?

extension Resource {
    func hasResource(handler: @escaping (T?)->Void) {
        if let value = value {
            return handler(value)
        }
        return handler(nil)
    }
}

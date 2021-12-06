//
//  ErrorParser.swift
//  GBShop
//
//  Created by Denis Kuzmin on 01.12.2021.
//

import Foundation

class ErrorParser: AbstractErrorParser {
    func parse(_ result: Error) -> Error {
        return result
    }
    
    func parse(response: HTTPURLResponse?, data: Data?, error: Error?) -> Error? {
        return error
    }
}

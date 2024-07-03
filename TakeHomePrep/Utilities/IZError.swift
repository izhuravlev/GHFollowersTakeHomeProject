//
//  IZError.swift
//  TakeHomePrep
//
//  Created by Ilya Zhuravlev on 2024-07-02.
//

import Foundation

enum IZError: String, Error {
    case invalidUsername = "This Username created an invalid request, please try again"
    case unableToComplete = "Unable to complete your request, please check your Internet Connection"
    case invalidResponse = "Invalid response from the server. Please try again."
    case invalidData = "The data received from the server was invalid. Please try again"
    case decoderFailure = "The data wasn't decoded properly"
}

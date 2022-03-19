//
//  AnalyticService.swift
//  GBShop
//
//  Created by Denis Kuzmin on 27.01.2022.
//

import Firebase

final class AnalyticService {
    static func login(userId: String, token: String, eMail: String) {
        Analytics.logEvent(AnalyticsEventLogin, parameters: [
            "userId": userId,
            "token": token,
            "email": eMail])
        Crashlytics.crashlytics().setUserID(userId)
    }
    
    static func logout(token: String) {
        Analytics.logEvent("Logout", parameters: [
            "token": token])
    }
    
    static func signUp(userName: String, name: String, lastName: String, eMail: String) {
        Analytics.logEvent(AnalyticsEventSignUp, parameters: [
            "userName": userName,
            "name": name,
            "lastName": lastName,
            "email": eMail])
    }
    
    static func addToCart(userId: String, productId: String, quantity: String, cost: String) {
        Analytics.logEvent(AnalyticsEventAddToCart, parameters: [
            AnalyticsParameterCurrency: "RUB",
            AnalyticsParameterValue: cost,
            quantity: quantity,
            "userId": userId,
            "productId": productId])
    }
    
    static func removeFromCart(userId: String, productId: String, quantity: String, cost: String) {
        Analytics.logEvent(AnalyticsEventRemoveFromCart, parameters: [
            AnalyticsParameterCurrency: "RUB",
            AnalyticsParameterValue: cost,
            quantity: quantity,
            "userId": userId,
            "productId": productId])
    }
}

/*
 Analytics.logEvent("Login", parameters: [
     "userId": user?.id.uuidString ?? "",
     "token": self.token ?? "",
 ])
 
 kFIRParameterCurrency (NSString) (optional)
 kFIRParameterItems (NSArray) (optional)
 kFIRParameterValue (double as NSNumber) (optional)
 */

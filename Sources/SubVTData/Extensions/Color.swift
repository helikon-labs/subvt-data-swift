//
//  Color.swift
//  
//
//  Created by Kutsal Kaan Bilgin on 29.07.2022.
//
//  Taken from the Nova Wallet Substrate SDK.
//  https://github.com/nova-wallet/substrate-sdk-ios/blob/master/SubstrateSdk/Classes/Common/UIColor%2BHSL.swift
//

import SwiftUI

extension Color {
    static func colorWithHSL(
        hue: CGFloat,
        saturation: CGFloat,
        lightness: CGFloat
    ) -> Color {
       var r: CGFloat = 0
       var g: CGFloat = 0
       var b: CGFloat = 0

       let h = max(min(hue, 360.0), 0.0)
       let s = max(min(saturation, 1.0), 0.0)
       let l = max(min(lightness, 1.0), 0.0)

       let c: CGFloat = (1 - abs((2.0 * l) - 1)) * s
       let h60: CGFloat = h / 60.0
       let x: CGFloat = c * CGFloat(1 - abs(h60.truncatingRemainder(dividingBy: 2.0) - 1))

       if h < 60.0 {
           r = c
           g = x
       } else if h < 120.0 {
           r = x
           g = c
       } else if h < 180.0 {
           g = c
           b = x
       } else if h < 240.0 {
           g = x
           b = c
       } else if h < 300.0 {
           r = x
           b = c
       } else if h < 360.0 {
           r = c
           b = x
       }

       let m: CGFloat = lightness - (c / 2.0)

       r += m
       g += m
       b += m

       return Color(red: r, green: g, blue: b, opacity: 1.0)
   }
}

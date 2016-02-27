////
////  ImageProcess.swift
////  imageFilter
////
////  Created by HOU YADDA on 16.12.15.
////  Copyright © 2015 houyadda. All rights reserved.
////
//
//import Foundation
//
////: Playground - noun: a place where people can play
//
//import UIKit
//
//
//
//let image = UIImage(named: "sample")!
//
//// Process the image!
//let rgbaImage = RGBAImage(image: image)
//
//var totalRed = 0
//var totalGreen = 0
//var totalBlue = 0
//
//let pixelCount = rgbaImage!.width * rgbaImage!.height
//
//let avgRed = 118 //totalRed/pixelCount
//let avgGreen = 98 //totalGreen/pixelCount
//let avgBlue = 83 //totalBlue/pixelCount
//
//class Filter{
//    var filterToApply = ""
//    var x = 0
//    
//    func selectFilter(filterToApply: String){
//        switch(filterToApply){
//        case "maximize colors":
//            maximizeColors()
//        case "translate " + String(x):
//            translateX(x)
//        default:
//            break
//        }
//    }
//    
//    func maximizeColors(){
//        for y in 0..<rgbaImage!.height{
//            for x in 0..<rgbaImage!.width{
//                let index = y * rgbaImage!.width + x
//                var pixel = rgbaImage?.pixels[index]
//                
//                if pixel?.red < UInt8(avgRed) {
//                    pixel?.red = 0
//                }else{
//                    pixel?.red = 255 // UInt8(Int((pixel?.red)!))
//                }
//                
//                if pixel?.green < UInt8(avgGreen) {
//                    pixel?.green = 0
//                }else{
//                    pixel?.green = 255 // UInt8(Int((pixel?.red)!))
//                }
//                
//                if pixel?.blue < UInt8(avgBlue) {
//                    pixel?.blue = 0
//                }else{
//                    pixel?.blue = 255 // UInt8(Int((pixel?.red)!))
//                }
//                
//                rgbaImage?.pixels[index] = pixel!
//            }
//        }
//    }
//    
//    func translateX(translationValue: Int){
//        for y in 0..<rgbaImage!.height{
//            for x in 0..<rgbaImage!.width{
//                let index = y * rgbaImage!.width + x
//                let pixel = rgbaImage?.pixels[index]
//                
//                var pixel1 = pixel
//                
//                if index < ((rgbaImage?.width)! * (rgbaImage?.height)!)-translationValue {
//                    pixel1 = rgbaImage?.pixels[index+translationValue]
//                    rgbaImage?.pixels[index] = pixel1!
//                    
//                }else {
//                    rgbaImage?.pixels[index] = pixel!
//                    
//                }
//                
//                
//            }
//        }
//    }
//    
//    func distort(distortionValue : Int){
//        for y in 0..<rgbaImage!.height{
//            for x in 0..<rgbaImage!.width{
//                let index = y * rgbaImage!.width + x
//                let pixel = rgbaImage?.pixels[index]
//                var pixel1 = pixel
//                
//                
//                if y%2 == 0 && index < rgbaImage!.width*rgbaImage!.height-distortionValue{
//                    pixel1 = rgbaImage?.pixels[index+distortionValue]
//                    rgbaImage?.pixels[index] = pixel1!
//                }else {
//                    rgbaImage?.pixels[index] = pixel!
//                    
//                }
//                
//                
//            }
//        }
//    }
//    
//    
//    func contrast(effect : Int){
//        for y in 0..<rgbaImage!.height{
//            for x in 0..<rgbaImage!.width{
//                let index = y * rgbaImage!.width + x
//                var pixel = rgbaImage?.pixels[index]
//                
//                let deltaRed = Int(pixel!.red)-avgRed
//                let deltaGreen = Int(pixel!.green)-avgGreen
//                let deltaBlue = Int(pixel!.blue)-avgBlue
//                
//                pixel!.red = UInt8(max(min(255, (avgRed + deltaRed * effect)),0))
//                pixel!.green = UInt8(max(min(255, (avgGreen + deltaGreen * effect)),0))
//                pixel!.blue = UInt8(max(min(255, (avgBlue + deltaBlue * effect)),0))
//                
//                rgbaImage?.pixels[index] = pixel!
//                
//                
//            }
//        }
//    }
//    
//    func brightness(effect : Int){
//        for y in 0..<rgbaImage!.height{
//            for x in 0..<rgbaImage!.width{
//                let index = y * rgbaImage!.width + x
//                var pixel = rgbaImage?.pixels[index]
//                
//                pixel!.red = UInt8(min(255, Int(pixel!.red) * effect))
//                pixel!.green = UInt8(min(255, Int(pixel!.green) * effect))
//                pixel!.blue = UInt8(min(255, Int(pixel!.blue) * effect))
//                
//                rgbaImage?.pixels[index] = pixel!
//                
//                
//            }
//        }
//    }
//    
//}
//
//var myFilter = Filter()
//
//myFilter.selectFilter("translate 5")
//
//
//image
//
//let newImage = rgbaImage?.toUIImage()

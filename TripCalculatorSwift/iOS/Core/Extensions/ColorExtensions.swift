//
//  ColorExtension.swift
//  TripCalculatorSwift
//
//  Created by Hanan Farizta on 19/09/24.
//

import SwiftUI

extension Color {
    
    init(hex: String) {
        self.init(UIColor(hex: hex))
    }
    
    init(r: Double, g: Double, b: Double) {
        self.init(red: r / 255.0, green: g / 255.0, blue: b / 255.0)
    }
    
    static func randomColor() -> Color {
        return Color(UIColor.random())
    }
    
}

extension Color {
    func getRGBComponents() -> (Double, Double, Double) {
        let colorComponents = self.description.components(separatedBy: " ").dropFirst()
        return ( (Double(colorComponents[1]) ?? 0) * 255, (Double(colorComponents[2]) ?? 0) * 255, (Double(colorComponents[3]) ?? 0) * 255)
    }
    
    func toRGB() -> (red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat)? {
        #if canImport(UIKit)
        typealias NativeColor = UIColor
        #elseif canImport(AppKit)
        typealias NativeColor = NSColor
        #endif
        
        let nativeColor = NativeColor(self)
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var alpha: CGFloat = 0
        
        nativeColor.getRed(&red, green: &green, blue: &blue, alpha: &alpha)
        
        return (red, green, blue, alpha)
    }
}

extension UIColor {
    /// For converting Hex-based colors
    convenience init(hex: String) {
        var hexSanitized = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        hexSanitized = hexSanitized.replacingOccurrences(of: "#", with: "")
        var rgb: UInt64 = 0
        
        var r: CGFloat = 0.0
        var g: CGFloat = 0.0
        var b: CGFloat = 0.0
        var a: CGFloat = 1.0
        
        let length = hexSanitized.count
        Scanner(string: hexSanitized).scanHexInt64(&rgb)
        
        if length == 6 {
            r = CGFloat((rgb & 0xFF0000) >> 16) / 255.0
            g = CGFloat((rgb & 0x00FF00) >> 8) / 255.0
            b = CGFloat(rgb & 0x0000FF) / 255.0
            
        } else if length == 8 {
            r = CGFloat((rgb & 0xFF000000) >> 24) / 255.0
            g = CGFloat((rgb & 0x00FF0000) >> 16) / 255.0
            b = CGFloat((rgb & 0x0000FF00) >> 8) / 255.0
            a = CGFloat(rgb & 0x000000FF) / 255.0
        }
        self.init(red: r, green: g, blue: b, alpha: a)
    }
    
    
    
    static func fromHex(rgbValue: UInt32, alpha: Double=1.0) -> UIColor {
        let red = CGFloat((rgbValue & 0xFF0000) >> 16)/256.0
        let green = CGFloat((rgbValue & 0xFF00) >> 8)/256.0
        let blue = CGFloat(rgbValue & 0xFF)/256.0
        
        return UIColor(red:red, green:green, blue:blue, alpha:CGFloat(alpha))
    }
    
    convenience init(red: Double, green: Double, blue: Double) {
        let red: Double = red
        let green: Double = green
        let blue: Double = blue
        
        self.init(red: Double(red) / 255.0, green: Double(green) / 255.0, blue: Double(blue) / 255.0, alpha: 1.0)
    }
}

extension UIColor {
    var toHex: String? {
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var alpha: CGFloat = 0

        guard self.getRed(&red, green: &green, blue: &blue, alpha: &alpha) else {
            return nil
        }

        let r = Int(red * 255)
        let g = Int(green * 255)
        let b = Int(blue * 255)
        let a = Int(alpha * 255)

        if alpha == 1 {
            return String(format: "#%02X%02X%02X", r, g, b)
        } else {
            return String(format: "#%02X%02X%02X%02X", r, g, b, a)
        }
    }
}

extension Color {
    func toHex() -> String {
        let uiColor = UIColor(self)
        return uiColor.toHex ?? ""
    }
}

extension UIColor {
    convenience init(_ color: Color) {
        let components = color.cgColor?.components
        let red = components?[0] ?? 0.0
        let green = components?[1] ?? 0.0
        let blue = components?[2] ?? 0.0
        let alpha = components?[3] ?? 1.0
        self.init(red: red, green: green, blue: blue, alpha: alpha)
    }
}

extension CGFloat {
    static func random() -> CGFloat {
        return CGFloat(arc4random()) / CGFloat(UInt32.max)
    }
}

extension UIColor {
    static func random() -> UIColor {
        return UIColor(
            red:   .random(),
            green: .random(),
            blue:  .random(),
            alpha: 1.0
        )
    }
}


extension UIImage {
    func getAverageColor(onCompletion: @escaping (UIColor) -> Void) {
        guard let inputImage = CIImage(image: self) else { return  }
        
        let extentVector = CIVector(x: inputImage.extent.origin.x, y: inputImage.extent.origin.y, z: inputImage.extent.size.width, w: inputImage.extent.size.height)
        guard let filter = CIFilter(name: "CIAreaAverage", parameters: [kCIInputImageKey: inputImage, kCIInputExtentKey: extentVector]) else { return  }
        guard let outputImage = filter.outputImage else { return  }
        
        var bitmap = [UInt8](repeating: 0, count: 4)
        let context = CIContext(options: [.workingColorSpace: kCFNull!])
        context.render(outputImage, toBitmap: &bitmap, rowBytes: 4, bounds: CGRect(x: 0, y: 0, width: 1, height: 1), format: .RGBA8, colorSpace: nil)
        onCompletion(UIColor(red: CGFloat(bitmap[0]) / 255, green: CGFloat(bitmap[1]) / 255 , blue: CGFloat(bitmap[2]) / 255, alpha: 1))
    }
    
    func computeLightColor(variation: CGFloat = 0.625) -> UIColor {
        var averageColor: UIColor = .systemTeal
        let _ = self.getAverageColor{ (color) in
            
            var red: CGFloat = 0
            var green: CGFloat = 0
            var blue: CGFloat = 0
            var alpha: CGFloat = 0
            color.getRed(&red, green: &green, blue: &blue, alpha: &alpha)
            
            averageColor = color
        }
        
        var red: CGFloat = 0
                  var green: CGFloat = 0
                  var blue: CGFloat = 0
                  var alpha: CGFloat = 0
        averageColor.getRed(&red, green: &green, blue: &blue, alpha: &alpha)
        
        let alternateColor = UIColor(red: Double(red) + variation, green: Double(green) + variation, blue: Double(blue) + variation, alpha: alpha)
        return alternateColor
    }
}

extension UIColor {
    func toColor() -> Color {
        return Color(self)
    }
}

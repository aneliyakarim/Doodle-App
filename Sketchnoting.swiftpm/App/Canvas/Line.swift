//
//  File.swift
//  
//
//  Created by Aneliya Mukhamedkarimova on 10/04/23.
//

import SwiftUI

struct Line: Identifiable, Equatable, Codable {
    var points: [CGPoint]
    var color: Color {
        return Color(rgbaColor)
    }
    private var rgbaColor: RGBAColor
    var lineWidth: CGFloat
    var id = UUID()
    
    init(points: [CGPoint], color: Color, lineWidth: CGFloat) {
        self.points = points
        self.rgbaColor = color.rgbaColor
        self.lineWidth = lineWidth
    }
}

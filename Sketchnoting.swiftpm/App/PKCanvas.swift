//
//  File.swift
//  
//
//  Created by Aneliya Mukhamedkarimova on 02/05/23.
//

import SwiftUI
import PencilKit

struct PKCanvas: UIViewRepresentable {
    @Binding var canvasView: PKCanvasView
    @State var toolPicker = PKToolPicker()
    
    func makeUIView(context: Context) -> PKCanvasView {
        canvasView.drawingPolicy = .anyInput
        canvasView.isOpaque = false
        showToolPicker()
        return canvasView
    }
    
    func updateUIView(_ uiView: PKCanvasView, context: Context) {
        
    }
    
    func showToolPicker() {
        toolPicker.setVisible(true, forFirstResponder: canvasView)
        toolPicker.addObserver(canvasView)
        canvasView.becomeFirstResponder()
    }
}

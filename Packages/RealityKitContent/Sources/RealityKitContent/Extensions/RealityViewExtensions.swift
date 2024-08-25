//
//  RealityViewExtensions.swift
//  RealityKitContent
//
//  Created by 박상욱 on 8/25/24.
//


import RealityKit
import SwiftUI

public extension RealityView {
    
    func installAllGestures() -> some View {
        simultaneousGesture(tapGesture)
            .simultaneousGesture(dragGesture)
            .simultaneousGesture(rotateGesture)
    }
    
    var tapGesture: some Gesture {
        TapGesture()
            .targetedToAnyEntity()
            .useGestureComponent()
    }
    
    var dragGesture: some Gesture {
        DragGesture()
            .targetedToAnyEntity()
            .useGestureComponent()
    }
    
    var rotateGesture: some Gesture {
        RotateGesture3D()
            .targetedToAnyEntity()
            .useGestureComponent()
    }
}

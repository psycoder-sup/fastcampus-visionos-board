//
//  File.swift
//  RealityKitContent
//
//  Created by 박상욱 on 8/25/24.
//

import Foundation
import RealityKit
import SwiftUI

extension Gesture where Value == EntityTargetValue<TapGesture.Value> {
    @MainActor func useGestureComponent() -> some Gesture {
        onEnded { value in
            guard var gestureComponent = value.entity.gestureComponent else { return }
            gestureComponent.onEnded(value: value)
        }
    }
}

extension Gesture where Value == EntityTargetValue<DragGesture.Value> {
    @MainActor func useGestureComponent() -> some Gesture {
        onChanged { value in
            guard var gestureComponent = value.entity.gestureComponent else { return }
            gestureComponent.onChanged(value: value)
//            print("Position: \(value.entity.scenePosition)")
        }
        .onEnded { value in
            guard var gestureComponent = value.entity.gestureComponent else { return }
            gestureComponent.onEnded(value: value)
        }
    }
}

extension Gesture where Value == EntityTargetValue<RotateGesture3D.Value> {
    @MainActor func useGestureComponent() -> some Gesture {
        onChanged { value in
            guard var gestureComponent = value.entity.gestureComponent else { return }
            gestureComponent.onChanged(value: value)
        }
        .onEnded { value in
            guard var gestureComponent = value.entity.gestureComponent else { return }
            gestureComponent.onEnded(value: value)
        }
    }
}

//
//  GestureComponent.swift
//  RealityKitContent
//
//  Created by 박상욱 on 8/25/24.
//

import RealityKit
import SwiftUI


class EntityGestureState: Codable {
    var targetEntity: UInt64?
    var dragStartPosition: SIMD3<Float> = .zero
    var isDragging: Bool = false
    var startOrientation: Rotation3D = .identity
    var isRotating = false
}

@MainActor
public struct GestureComponent: Component, Codable {
    
    var canDrag = true
    var canTap = true
    var isYellow = true
    var canRotate = true
    
    static var shared = EntityGestureState()
    
    
    mutating public func onEnded(value: EntityTargetValue<TapGesture.Value>) {
        guard canTap else { return }
        
        let state = GestureComponent.shared
        if state.targetEntity == nil {
            state.targetEntity = value.entity.id
        }
        
        handleTap(value: value)
        
        state.targetEntity = nil
    }
    
    mutating private func handleTap(value: EntityTargetValue<TapGesture.Value>) {
        let entity = value.entity
        
        guard var model = entity.components[ModelComponent.self] else {
            return
        }
        if var material = model.materials.first as? SimpleMaterial {
            material.color.tint = isYellow ? .green : .yellow
            self.isYellow = isYellow ? false : true
            model.materials = [material]
            entity.components.set([model, self])
        }
    }
    
    mutating public func onChanged(value: EntityTargetValue<DragGesture.Value>) {
        guard canDrag else { return }
        
        let state = GestureComponent.shared
        
        if state.targetEntity == nil {
            state.targetEntity = value.entity.id
        }
        
        handleDrag(value: value)
    }
    
    mutating private func handleDrag(value: EntityTargetValue<DragGesture.Value>) {
        let state = GestureComponent.shared
        
        if !state.isDragging {
            state.isDragging = true
            state.dragStartPosition = value.entity.scenePosition
        }
        
        let translation3D = value.convert(value.gestureValue.translation3D, from: .local, to: .scene)
        
        let offset = SIMD3<Float>(x: Float(translation3D.x), y: Float(translation3D.y), z: 0)
        
        let newPosition = state.dragStartPosition + offset
        
        value.entity.scenePosition = newPosition.clamped(lowerBound: [-0.5, -0.31, -.infinity], upperBound: [0.4, 0.2, .infinity])
    }
    
    mutating public func onEnded(value: EntityTargetValue<DragGesture.Value>) {
        let state = GestureComponent.shared
        state.isDragging = false
        state.targetEntity = nil
    }
    
    mutating func onChanged(value: EntityTargetValue<RotateGesture3D.Value>){
        let state = GestureComponent.shared
        guard canRotate, !state.isDragging else { return }
        
        let entity = value.entity
        
        if !state.isRotating {
            state.isRotating = true
            state.startOrientation = .init(entity.orientation(relativeTo: nil))
        }
        
        let rotation = value.rotation
        
        let newRotation = Rotation3D(angle: rotation.angle, axis: RotationAxis3D(x: 0, y: 0, z: rotation.axis.z))
        
        let newOrientation = state.startOrientation.rotated(by: newRotation)
        entity.setOrientation(.init(newOrientation), relativeTo: nil)
    }
    
    mutating func onEnded(value: EntityTargetValue<RotateGesture3D.Value>){
        GestureComponent.shared.isRotating = false
    }
}

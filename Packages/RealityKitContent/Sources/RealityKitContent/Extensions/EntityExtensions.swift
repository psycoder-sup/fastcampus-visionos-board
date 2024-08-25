//
//  EntityExtensions.swift
//  RealityKitContent
//
//  Created by 박상욱 on 8/25/24.
//


import RealityKit

extension Entity {
    
    var scenePosition: SIMD3<Float> {
        get { position(relativeTo: nil) }
        set { setPosition(newValue, relativeTo: nil)}
    }
    
    var gestureComponent: GestureComponent? {
        get { components[GestureComponent.self] }
        set { components[GestureComponent.self] = newValue }
    }
    
    
    static public func createNote() -> Entity {
        var material = SimpleMaterial(color: .yellow, isMetallic: false)
        material.metallic = 0
        material.roughness = 1
        let entity = ModelEntity(mesh: .generateBox(size: .init(0.1, 0.1, 0.001)), materials: [material])
        
        entity.setPosition(.init(0.0, 0.0, 0.008), relativeTo: nil)
        entity.gestureComponent = GestureComponent()
        entity.components.set([HoverEffectComponent(), InputTargetComponent()])
        entity.generateCollisionShapes(recursive: false)
        
        return entity
    }
    
    static public func createBoard() -> Entity? {
        let entity = try? Entity.load(named: "BoardScene", in: realityKitContentBundle)
        guard let entity else { return nil }
        entity.setScale(.init(repeating: 2), relativeTo: nil)
        entity.setPosition(.init(0, 0, -0.1), relativeTo: nil)
        
        return entity
    }
}

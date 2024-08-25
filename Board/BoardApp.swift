//
//  BoardApp.swift
//  Board
//
//  Created by 박상욱 on 8/25/24.
//

import SwiftUI
import RealityKitContent

@main
struct BoardApp: App {
    
    init() {
        RealityKitContent.GestureComponent.registerComponent()
    }


    var body: some Scene {
        WindowGroup {
            BoardScene()
        }
        .windowStyle(.volumetric)
        .defaultSize(width: 1.5, height: 1, depth:  0.2, in: .meters)

    }
}

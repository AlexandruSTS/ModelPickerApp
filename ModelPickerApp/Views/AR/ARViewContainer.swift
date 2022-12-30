//
//  ARViewContainer.swift
//  ModelPickerApp
//
//  Created by Alex Anghel on 29/12/2022.
//

import SwiftUI
import RealityKit
import ARKit
import FocusEntity

struct ARViewContainer: UIViewRepresentable {
    
    @Binding var modelConfirmedForPlacement: Model?
    
    func makeUIView(context: Context) -> ARView {
        
        let arView = FocusARView(frame: .zero)
    
        return arView
    }
    
    func updateUIView(_ uiView: ARView, context: Context) {
        
        if let model = self.modelConfirmedForPlacement {
            let anchorEntity = AnchorEntity(plane: .any)
            if let modelEntity = model.modelEntity {
                print("ARContainer -> DEBUG: adding model to scene - \(model.modelName)"  )
                anchorEntity.addChild(modelEntity)
                
                uiView.scene.addAnchor(anchorEntity)
            }
            else{
                print("ARContainer -> DEBUG: Unable to load model to scene - \(model.modelName)"  )
            }
        }
    }
}

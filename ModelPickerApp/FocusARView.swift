//
//  FocusARView.swift
//  ModelPickerApp
//
//  Created by Alex Anghel on 30/12/2022.
//

import SwiftUI
import RealityKit
import ARKit
import FocusEntity

class FocusARView: ARView {
    enum FocusStyleChoices {
        case classic
        case material
        case color
    }
    
    /// Style to be displayed in the example
    let focusStyle: FocusStyleChoices = .color
    var focusEntity: FocusEntity?
    required init(frame frameRect: CGRect) {
        super.init(frame: frameRect)
        self.setupConfig()
        
        switch self.focusStyle {
        case .color:
            self.focusEntity = FocusEntity(on: self, focus: .classic)
        case .material:
            do {
                let onColor: MaterialColorParameter = try .texture(.load(named: "Add"))
                let offColor: MaterialColorParameter = try .texture(.load(named: "Open"))
                self.focusEntity = FocusEntity(
                    on: self,
                    style: .colored(
                        onColor: onColor, offColor: offColor,
                        nonTrackingColor: offColor
                    )
                )
            } catch {
                self.focusEntity = FocusEntity(on: self, focus: .classic)
                print("DEBUG: Unable to load plane textures")
                print(error.localizedDescription)
            }
        default:
            self.focusEntity = FocusEntity(on: self, focus: .classic)
        }
    }
    
    func setupConfig() {
        
        let config = ARWorldTrackingConfiguration()
        config.planeDetection = [.horizontal, .vertical ]
        config.environmentTexturing = .automatic
        if ARWorldTrackingConfiguration.supportsSceneReconstruction(.mesh){
            config.sceneReconstruction = .mesh
        }
        self.session.run(config)
    }
    
    @objc required dynamic init?(coder decoder: NSCoder) {
        fatalError("DEBUG: init(coder:) has not been implemented")
    }
}

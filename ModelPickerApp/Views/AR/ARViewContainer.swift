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
    @Binding var selectedColor: UIColor?
    
    func makeUIView(context: Context) -> ARView {
        
        let arView = FocusARView(frame: .zero)
        
        return arView
    }
    
    func updateUIView(_ uiView: ARView, context: Context) {
        
        if let model = self.modelConfirmedForPlacement {
            let anchorEntity = AnchorEntity(plane: .any)
            if let modelEntity = model.modelEntity {
                            
                changeTexture(modelEntity: modelEntity, color: self.selectedColor! )
                anchorEntity.addChild(modelEntity)
                uiView.scene.addAnchor(anchorEntity)
            }
            else{
                print("ARContainer -> DEBUG: Unable to load model to scene - \(model.modelName)" )
            }
        }
    }
    
    func changeTexture(modelEntity: ModelEntity, color: UIColor){
        guard var modelComponent = modelEntity.components[ModelComponent.self] as? ModelComponent else {
            return
        }
        var meshModelId = "/" + modelEntity.name + "/" + MeshEnum.front.rawValue
        
        print("meshIdName: \(meshModelId)")
        print("mesh: \( modelEntity.model!.mesh.contents.models )")
        
        if let meshComponent: MeshResource.Model = modelEntity.model!.mesh.contents.models.first(where:
                                                                                                    {$0.id == meshModelId + "/primitive_0"} ) {
            print("Mesh ->  \(meshComponent) ")
            
            if let part: MeshResource.Part = meshComponent.parts["MeshPart"] {
                modelComponent.materials[part.materialIndex] = createMaterialPhysicallyBasedMaterial(color: color)
            }
            
        }
        if let meshComponent: MeshResource.Model = modelEntity.model!.mesh.contents.models.first(where:
                                                                                                    {$0.id == meshModelId + "/primitive_1"} ) {
            if let part: MeshResource.Part = meshComponent.parts["MeshPart"] {
                modelComponent.materials[part.materialIndex] = createMaterialPhysicallyBasedMaterial(color: color)
            }
            print("Mesh ->  \(meshComponent) ")
        }
        //Versiunea Dan
        //                guard var modelComponent = modelEntity.components[ModelComponent.self] as? ModelComponent else {
        //                    return
        //                }
        //
        //                if let meshComponent: MeshResource.Model = modelComponent.mesh.contents.models
        //                    .first(where:  {$0.id == "/" + model.modelName + "/the_one_cone/Geom/" + MeshEnum.front.rawValue + "/primitive_0"}){
        //
        //                    if let part: MeshResource.Part = meshComponent.parts["MeshPart"] {
        //                        modelComponent.materials[part.materialIndex] = createMaterialPhysicallyBasedMaterial()
        //                    }
        //                }
        //                print(modelComponent.mesh.contents.models)
        //                if let meshComponent: MeshResource.Model = modelComponent.mesh.contents.models
        //                    .first(where:  {$0.id == "/" + model.modelName +  "/the_one_cone/Geom/" + MeshEnum.front.rawValue}){
        //
        //                    if let part: MeshResource.Part = meshComponent.parts["MeshPart"] {
        //                        modelComponent.materials[part.materialIndex] = createMaterialPhysicallyBasedMaterial()
        //                    }
        //                }
        
        modelEntity.components.set(modelComponent)
    }
    
    func createMaterialPhysicallyBasedMaterial(color: UIColor) -> PhysicallyBasedMaterial{
        var material = PhysicallyBasedMaterial();
        
        material.baseColor = PhysicallyBasedMaterial.BaseColor(tint:UIColor(Color(color)))
        
        return material
    }
}

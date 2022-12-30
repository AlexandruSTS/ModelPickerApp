//
//  Model.swift
//  ModelPickerApp
//
//  Created by Alex Anghel on 29/11/2022.
//

import Foundation
import UIKit
import RealityKit
import Combine
import SwiftUI

class Model {
    
    var modelName: String
    var image: UIImage
    var modelEntity: ModelEntity?
    
    private var cancellable: AnyCancellable? = nil
    
    init(modelName: String){
        self.modelName = modelName
        
        self.image = UIImage(named: modelName)!
        
        let filename = modelName + ".usdz"
        
        self.cancellable = ModelEntity.loadModelAsync(named: filename)
            .sink(receiveCompletion: { loadCompletion in
                print("Model -> DEBUG: Unable to load modelEntity for modelName: \(self.modelName)")
            }, receiveValue: { modelEntity in
                if self.modelName.hasPrefix("toy_"){
                    self.modelEntity = modelEntity
                }
                //setting scale 1 for glasses usdz files
                else{
                    modelEntity.scale = SIMD3(x: 1, y: 1, z: 1)
                    
                    var simpleMat = SimpleMaterial()
                            simpleMat.color = .init(tint: .blue, texture: nil)
                            simpleMat.metallic = .init(floatLiteral: 0.7)
                            simpleMat.roughness = .init(floatLiteral: 0.2)
                            
                            var pbr = PhysicallyBasedMaterial()
                            pbr.baseColor = .init(tint: .green, texture: nil)

//                            let mesh: MeshResource = .generateBox(width: 0.5,
//                                                                 height: 0.5,
//                                                                  depth: 0.5,
//                                                           cornerRadius: 0.02,
//                                                             splitFaces: true)
//                    let mesh = modelComponent!.mesh.contents.models
//                        .first(where: <#T##(MeshResource.Model) throws -> Bool#>)
//
//                    let boxComponent = ModelComponent(mesh: mesh,
//                                                         materials: [pbr])
//
//                    modelEntity.components.set(boxComponent)
                    print("materials entity -> \(modelName) number -> \(modelEntity.model?.materials.count) " )
                    let modelComponent = modelEntity.components[ModelComponent.self] as? ModelComponent
                    
                    
                    for material in modelEntity.model!.materials {
                        
                        print("materials entity \(material) ")
                    }

                    self.modelEntity = modelEntity
                }
                print("Model -> DEBUG: Succesfully loaded modelEntity for modelName: \(self.modelName)")
            })
    }
}

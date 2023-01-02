//
//  ContentView.swift
//  ModelPickerApp
//
//  Created by Alex Anghel on 29/11/2022.
//

import SwiftUI
import RealityKit
import ARKit

struct ContentView : View {
    
    @State private var isPlacementEnabled = false
    @State private var isPlacementEnabledColor = false
    @State private var selectedModel: Model?
    @State private var modelConfirmedForPlacement: Model?
    @State private var selectedColor: UIColor?
    
    private var models: [Model] {
        //Dynamicaly get file names
        let filemanager = FileManager.default
        
        guard let path = Bundle.main.resourcePath,
              let files = try? filemanager.contentsOfDirectory(atPath: path)
        else {
            return []
        }
        var availableModels: [Model] = []
        
        for filename in files where filename.hasSuffix("usdz") {
            let modelName = filename.replacingOccurrences(of: ".usdz", with: "")
            
            let model = Model(modelName: modelName)
            
            availableModels.append(model)
        }
        return availableModels
    }
    
    var body: some View {
        ZStack(alignment: .bottom){
            ARViewContainer(modelConfirmedForPlacement: self.$modelConfirmedForPlacement, selectedColor: self.$selectedColor)
            
            if self.isPlacementEnabledColor {
                TexturePickerView(selectedColor: self.$selectedColor, isPlacementEnabled: self.$isPlacementEnabled )
                
                if self.isPlacementEnabled {
                    PlacementButtonsView( isPlacementEnabledColor: self.$isPlacementEnabledColor, isPlacementEnabled: self.$isPlacementEnabled,
                                          selectedModel: self.$selectedModel,
                                          modelConfirmedForPlacement: self.$modelConfirmedForPlacement )
                }
            }
            else {
                VStack(spacing: 0){
                    ModelPickerView( selectedModel: self.$selectedModel, isPlacementEnabledColor: self.$isPlacementEnabledColor, models: self.models)
                }
            }
        }
    }
}

#if DEBUG
struct ContentView_Previews : PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
#endif



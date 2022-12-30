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
    @State private var selectedModel: Model?
    @State private var modelConfirmedForPlacement: Model?
    
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
            ARViewContainer(modelConfirmedForPlacement: self.$modelConfirmedForPlacement)
            
            if self.isPlacementEnabled {
                PlacementButtonsView(isPlacementEnabled: self.$isPlacementEnabled,
                                     selectedModel: self.$selectedModel,
                                     modelConfirmedForPlacement: self.$modelConfirmedForPlacement)
            }
            else {
                ModelPickerView( isPlacementEnabled: self.$isPlacementEnabled,
                                selectedModel: self.$selectedModel, models: self.models)
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



//
//  ModelPicker.swift
//  ModelPickerApp
//
//  Created by Alex Anghel on 29/12/2022.
//

import SwiftUI

struct ModelPickerView: View {
    
    @Binding var isPlacementEnabled: Bool
    @Binding var selectedModel: Model?
    
    var models: [Model]

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false){
            HStack(spacing: 30){
                ForEach(0 ..< self.models.count , id: \.self){ index in
                    Button {
                        self.selectedModel = self.models[index]
                        self.isPlacementEnabled = true

                    } label: {
                        Image(uiImage: self.models[index].image)
                            .resizable()
                            .frame(height: 80 )
                            .aspectRatio(1/1, contentMode: .fit)
                            .background(Color.white)
                            .cornerRadius(12)
                    }
                    .buttonStyle(PlainButtonStyle())
                }
            }
        }
        .padding(20)
        .background(Color.black.opacity(0.5))
    }
}

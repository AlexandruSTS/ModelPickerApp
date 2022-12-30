//
//  PlacementButtonsView.swift
//  ModelPickerApp
//
//  Created by Alex Anghel on 29/12/2022.
//

import SwiftUI

struct PlacementButtonsView: View {
    
    @Binding var isPlacementEnabled: Bool
    @Binding var selectedModel: Model?
    @Binding var modelConfirmedForPlacement: Model?
    
    var body: some View {
        HStack{
            //Cancel button
            Button {
                self.resetParameters()
            } label: {
                Image(systemName: "xmark")
                    .frame(width: 60, height: 60)
                    .font(.title)
                    .background(Color.white.opacity(0.75))
                    .cornerRadius(30)
                    .padding(20)
            }
            //Confirm button
            Button {
                self.modelConfirmedForPlacement = self.selectedModel
                self.resetParameters()

            } label: {
                Image(systemName: "checkmark")
                    .frame(width: 60, height: 60)
                    .font(.title)
                    .background(Color.white.opacity(0.75))
                    .cornerRadius(30)
                    .padding(20)
            }
        }
    }
    
    func resetParameters(){
        self.isPlacementEnabled.toggle()
        self.selectedModel = nil
    }
    
}

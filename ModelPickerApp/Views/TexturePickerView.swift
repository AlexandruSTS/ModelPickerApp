//
//  TexturePickerView.swift
//  ModelPickerApp
//
//  Created by Alex Anghel on 30/12/2022.
//

import SwiftUI

struct TexturePickerView: View {
    
    @Binding  var selectedColor: UIColor?
    @Binding  var isPlacementEnabled: Bool

    var colors: [UIColor]{
        var availableColors: [UIColor] = []
        
        availableColors.append(.cyan)
        availableColors.append(.red)
        availableColors.append(.yellow)

        return availableColors
    }
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false){
            HStack(spacing: 30){
                ForEach(0 ..< self.colors.count , id: \.self){ index in
                    Button {
                        self.selectedColor = self.colors[index]
//                        print("DEBUG color: \( self.selectedColor)")
                        self.isPlacementEnabled.toggle()
                    } label: {
                        Circle()
                            .fill(Color(self.colors[index]))
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


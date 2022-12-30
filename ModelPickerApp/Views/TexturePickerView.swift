//
//  TexturePickerView.swift
//  ModelPickerApp
//
//  Created by Alex Anghel on 30/12/2022.
//

import SwiftUI

struct TexturePickerView: View {
    
    var colors: [Model]

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false){
            HStack(spacing: 30){
                ForEach(0 ..< self.colors.count , id: \.self){ index in
                    Button {
//                        self.selectedModel = self.models[index]
//                        self.isPlacementEnabled = true

                    } label: {
                        Image(systemName: "circle.circle.fill")
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

//struct TexturePickerView_Previews: PreviewProvider {
//    static var previews: some View {
//        TexturePickerView()
//    }
//}

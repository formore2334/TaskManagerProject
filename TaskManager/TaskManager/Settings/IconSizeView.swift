//
//  IconSizeView.swift
//  CoreDataTM
//
//  Created by ForMore on 04/07/2023.
//

import SwiftUI

struct IconSizeView: View {
    
    @ObservedObject var settingsManager: SettingsManager
    @State private var isConfirmed = false
    @State private var dragOffset: CGSize = .zero

    
    var body: some View {
        
        GeometryReader { geometry in
            VStack {
                
                VStack {
                    
                    Text("Choose icon size")
                        .foregroundColor(Color(.white))
                        .font(.title2)
                        .opacity(0.8)
                        .padding(20)
                        .padding(.top, 20)
                    
                    VStack {
                        
                        Image(settingsManager.selectedIconSize?.ImageName ?? "")
                            .resizable()
                            .shadow(radius: 5)
                            .frame(width: geometry.size.width * 0.4, height: geometry.size.height * 0.5)
                            .cornerRadius(10)
                            .animation(.interactiveSpring(response: 0.7, dampingFraction: 0.8, blendDuration: 0.5), value: settingsManager.selectedIconSize)
                            .shadow(radius: 5)
                            .gesture(
                                DragGesture()
                                    .onChanged { gesture in
                                        dragOffset = gesture.translation
                                    }
                                    .onEnded { gesture in
                                        withAnimation(.spring()) {
                                            dragOffset = .zero
                                            
                                            if gesture.translation.width > 50 {
                                                settingsManager.previousIcon()
                                            } else if gesture.translation.width < -50  {
                                                settingsManager.nextIcon()
                                            }
                                        }
                                    }
                            )
                    }
                    
                    
                    HStack(spacing: 80) {
                        
                        ForEach(IconSize.allCases, id: \.self) { size in
                            
                            Circle()
                                .fill(settingsManager.selectedIconSize == size ? Color(.systemPink).opacity(0.8) : .white)
                                .frame(width: 10, height: 10)
                                .overlay(
                                    Circle()
                                        .stroke(Color.black, lineWidth: 0.1)
                                )
                            
                                .onTapGesture {
                                    settingsManager.selectedIconSize = size
                                }
                        }
                        
                    }
                    .frame(width: geometry.size.width * 0.2)
                    .padding(30)
                    
                    Spacer()
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
    }
}


struct IconSizeView_Previews: PreviewProvider {
    static var previews: some View {
        IconSizeView(settingsManager: SettingsManager())
    }
}

//
//  DirectMenuStyleView.swift
//  CoreDataTM
//
//  Created by ForMore on 04/07/2023.
//

import SwiftUI


struct DirectMenuStyleView: View {
    @ObservedObject var settingsManager: SettingsManager
    @State private var isConfirmed = false
    
    var body: some View {
        GeometryReader { geometry in
            
            VStack {
                
                HStack {
                    Text("Choose your favorite style")
                        .foregroundColor(Color(.white))
                        .font(.title2)
                        .opacity(0.8)
                        .padding(20)
                        .padding(.top, 20)
                }
                
                HStack(spacing: 20) {
                    
                    Spacer()
                    
                    ForEach(DirectMenuStyle.allCases, id: \.self) { style in
                        
                        VStack {
                            
                            Image(style.rawValue)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .cornerRadius(10)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(Color(settingsManager.selectedStyle == style ? .systemPink : .clear).opacity(0.8), lineWidth: 0.8)
                                )
                                .frame(width: geometry.size.width * 0.35, height: geometry.size.height * 0.5)
                                .onTapGesture {
                                    settingsManager.selectedStyle = style
                                }
                            
                            
                            Circle()
                                .fill(settingsManager.selectedStyle == style ? Color(.systemPink).opacity(0.8) : .white)
                                .frame(width: 10, height: 10)
                                .overlay(
                                    Circle()
                                        .stroke(Color.black, lineWidth: 0.1)
                                )
                                .onTapGesture {
                                    settingsManager.selectedStyle = style
                                }
                                .padding(15)
                            
                        }
                        .frame(width: geometry.size.width * 0.2)
                        .padding(20)
                    }
                    
                    Spacer()
                }
                
                Spacer()
            }
        }
    }
}



//struct DirectMenuStyleView_Previews: PreviewProvider {
//    static var previews: some View {
//        DirectMenuStyleView()
//    }
//}

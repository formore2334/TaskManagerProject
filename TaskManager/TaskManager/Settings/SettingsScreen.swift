//
//  SettingsScreen.swift
//  CoreDataTM
//
//  Created by ForMore on 27/06/2023.
//

import SwiftUI


struct SettingsScreen: View {
    
    @ObservedObject var settingsManager: SettingsManager
    @State private var selectedSettings: SettingsTypes?
    
    var body: some View {
        NavigationView {
            VStack {
                VStack {
                    List {
                        ForEach(SettingsTypes.allCases, id: \.self) { settings in
                            Button(action: {
                                selectedSettings = settings
                            }) {
                                HStack {
                                    Text(settings.rawValue)
                                    Spacer()
                                    Image(systemName: "chevron.down.circle")
                                }
                                .padding()
                                .background(Color(.clear))
                                .foregroundColor(.black)
                                .frame(height: 35)
                            }
                        }
                    }
                    .listStyle(PlainListStyle())
                    .cornerRadius(10)
                    .frame(height: 130)
                    .padding(20)
                }
                Spacer()
                Rectangle()
                    .frame(height: 2)
                    .foregroundColor(Color(.systemGray4))
                    .opacity(0.8)
                    .cornerRadius(2)
                    .padding(.horizontal)
                
                VStack(spacing: 20) {
                    Spacer()
                    if selectedSettings == .directListStyle {
                        DirectMenuStyleView(settingsManager: settingsManager)
                    } else if selectedSettings == .iconSize {
                        IconSizeView(settingsManager: settingsManager)
                    } else if selectedSettings == .notifications {
                        NotificationsScreen(settingsManager: settingsManager)
                    } else {
                        
                        Text("Tap on settings item to see details")
                            .foregroundColor(Color(.white))
                            .font(.system(size: 40))
                            .opacity(0.8)
                            .lineLimit(nil)
                            .multilineTextAlignment(.center)
                            .frame(width: 200, height: 300)
                            .padding(20)
                        Spacer()
                    }
                }
                .cornerRadius(10)
                .scaleEffect(1.2)
                Spacer()
                
            }
            .navigationBarTitle("Settings", displayMode: .inline)
            .background(LinearGradient(gradient: Gradient(colors: [Color(.systemGray6), Color(.systemGray5)]), startPoint: .top, endPoint: .bottom))
        }
    }
}




struct SettingsScreen_Previews: PreviewProvider {
    static var previews: some View {
        SettingsScreen(settingsManager: SettingsManager())
    }
}



//List {
//    ForEach(SettingsCases.allCases, id: \.self) { setting in
//        Section(header: Text(setting.rawValue)) {
//            if setting == .mainMenuStyle {
//                Picker(selection: $settingsManager.mainMenuStyle, label: Text("")) {
//                    ForEach(MainMenuStyle.allCases, id: \.self) { style in
//                        Text(style.rawValue)
//                    }
//                }
//            } else if setting == .theme {
//                Toggle(isOn: $settingsManager.isShow) {
//                    Text("Dark Mode")
//                }
//            }
//            // Add more conditions to handle other settings options
//        }
//    }
//}







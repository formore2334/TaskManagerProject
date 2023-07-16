//
//  NotificationsScreen.swift
//  CoreDataTM
//
//  Created by ForMore on 12/07/2023.
//

import SwiftUI

struct NotificationsScreen: View {
    
    @ObservedObject var settingsManager: SettingsManager
    
    
    var body: some View {
        NavigationView {
            VStack {
                
                Rectangle()
                    .frame(height: 2)
                    .foregroundColor(Color(.systemGray4))
                    .opacity(0.8)
                    .cornerRadius(2)
                    .padding(.horizontal)
                
                List {
                    Group {
                        Text("Select for tasks with what priority you want to receive notifications")
                            .foregroundColor(Color(.systemGray))
                        
                        ForEach(AccordingPriority.allCases, id: \.self) { priority in
                            HStack {
                                Text(priority.rawValue)
                                Spacer()
                                Toggle("", isOn: Binding<Bool>(
                                    get: { self.settingsManager.accordingPriority == priority },
                                    set: { _ in self.settingsManager.accordingPriority = priority }
                                )).scaleEffect(0.8)
                            }
                        }
                    }
                    
                    Group {
                        Text("Choose how long before the end of the task you want to receive notifications")
                            .foregroundColor(Color(.systemGray))
                        
                        ForEach(AccordingTime.allCases, id: \.self) { time in
                            HStack {
                                Text(time.rawValue)
                                Spacer()
                                Toggle("", isOn: Binding<Bool>(
                                    get: { self.settingsManager.accordingTime?.contains(time) ?? false },
                                    set: { isOn in
                                        if isOn {
                                            self.settingsManager.accordingTime?.insert(time)
                                        } else {
                                            self.settingsManager.accordingTime?.remove(time)
                                        }
                                    }
                                )).scaleEffect(0.8)
                            }
                        }
                        
                    }
                }
            }
            .listStyle(InsetGroupedListStyle())
            .padding(.top, 50)
            .padding(.horizontal, 30)
            .background(Color(.systemGray6))
        }
    }
}


struct NotificationsScreen_Previews: PreviewProvider {
    static var previews: some View {
        NotificationsScreen(settingsManager: SettingsManager())
    }
}

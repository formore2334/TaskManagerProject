//
//  SettingsManager.swift
//  CoreDataTM
//
//  Created by ForMore on 01/07/2023.
//

import Foundation
import SwiftUI

class SettingsManager: ObservableObject {
    
    @Published var selectedStyle: DirectMenuStyle? {
        didSet {
            if let selectedStyle = selectedStyle {
                UserDefaults.standard.set(selectedStyle.rawValue, forKey: "selectedStyle")
            }
            objectWillChange.send()
        }
    }
        
    @Published var selectedIconSize: IconSize? {
        didSet {
            if let selectedIconSize = selectedIconSize {
                UserDefaults.standard.set(selectedIconSize.rawValue, forKey: "selectedIconSize")
            }
        }
    }
    
    @Published var accordingPriority: AccordingPriority? {
        didSet {
            if let accordingPriority = accordingPriority {
                UserDefaults.standard.set(accordingPriority.rawValue, forKey: "accordingPriority")
            }
        }
    }
    
    @Published var accordingTime: Set<AccordingTime>? {
        didSet {
            if let accordingTime = accordingTime {
                UserDefaults.standard.set(accordingTime.map { $0.rawValue }, forKey: "accordingTime")
            }
        }
    }
  
    
    init() {
        
        if let rawValue = UserDefaults.standard.string(forKey: "selectedStyle") {
              self.selectedStyle = DirectMenuStyle(rawValue: rawValue) ?? .brightStyle
          } else {
              self.selectedStyle = .brightStyle
          }
        
        if let rawValue = UserDefaults.standard.string(forKey: "selectedIconSize") {
            self.selectedIconSize = IconSize(rawValue: rawValue) ?? .normal
        } else {
            self.selectedIconSize = .normal
        }
        
        if let rawValue = UserDefaults.standard.string(forKey: "selectedPriority") {
            self.accordingPriority = AccordingPriority(rawValue: rawValue) ?? .high
        } else {
            self.accordingPriority = .high
        }
        
        if let rawValues = UserDefaults.standard.stringArray(forKey: "accordingTime") {
            self.accordingTime = Set(rawValues.compactMap { AccordingTime(rawValue: $0) })
        } else {
            self.accordingTime = Set([.oneHour, .oneDay])
        }
        
      }
    
    func nextIcon() {
        guard let currentIcon = self.selectedIconSize else { return }
    
    let allIcons = IconSize.allCases
    
        if let currentIndex = allIcons.firstIndex(of: currentIcon) {
            var nextIndex = currentIndex + 1
            if nextIndex >= allIcons.count {
                nextIndex = 0
            }
            self.selectedIconSize = allIcons[nextIndex]
        }
    }
    
    func previousIcon() {
        guard let currentIcon = self.selectedIconSize else { return }
    
    let allIcons = IconSize.allCases
    
        if let currentIndex = allIcons.firstIndex(of: currentIcon) {
            var nextIndex = currentIndex - 1
            if nextIndex < 0 {
                nextIndex = allIcons.count - 1
            }
            self.selectedIconSize = allIcons[nextIndex]
        }
    }
    
}

enum SettingsTypes: String, CaseIterable {
    case directListStyle = "Direct list style"
    case iconSize = "Icon Size"
    case notifications = "Notifications"
}

enum DirectMenuStyle: String, CaseIterable {
    case brightStyle = "BrightStyle"
    case strictStyle = "StrictStyle"
    
    var ImageName: String {
        switch self {
        case .brightStyle:
            return "BrightStyle"
        case .strictStyle:
            return "StrictStyle"
        }
    }
}

enum IconSize: String, CaseIterable {
    case small = "Small"
    case normal = "Normal"
    case large = "Large"
    
    var ImageName: String {
        switch self {
        case .small:
            return "IconSizeSmall"
        case .normal:
            return "IconSizeNormal"
        case .large:
            return "IconSizeLarge"
        }
    }
}

struct ListStyleModifier: ViewModifier {
    
    @ObservedObject var settingsManager: SettingsManager
    
    var isListStyleVisible: Bool {
      if settingsManager.selectedStyle == .brightStyle {
          return true
      } else {
          return false
      }
  }
    
    func body(content: Content) -> some View {
        if isListStyleVisible {
            return AnyView(content.listStyle(InsetGroupedListStyle()))
        } else {
            return AnyView(content.listStyle(GroupedListStyle()))
        }
    }
}

struct IconSizeModifier: ViewModifier {
    
    @ObservedObject var settingsManager: SettingsManager
    
    
    func body(content: Content) -> some View {
        if settingsManager.selectedIconSize == .small {
            return AnyView(content.scaleEffect(0.9))
        } else if settingsManager.selectedIconSize == .normal{
            return AnyView(content.scaleEffect(1.0))
        } else {
            return AnyView(content.scaleEffect(1.1).padding(.horizontal, 10))
        }
    }
}





//class SettingsManager: ObservableObject {
//
//    @Published var selectedStyle: DirectMenuStyle? {
//        didSet {
//            saveSelectedStyle()
//        }
//    }
//
//    @Published var selectedIconSize: IconSize? {
//        didSet {
//            saveSelectedIconSize()
//        }
//    }
//
//    @Published var isShow: Bool {
//        didSet {
//            UserDefaults.standard.set(isShow, forKey: "isShow")
//        }
//    }
//
//    init() {
//        self.isShow = UserDefaults.standard.bool(forKey: "isShow")
//        self.selectedStyle = loadSelectedStyle()
//        self.selectedIconSize = loadSelectedIconSize()
//    }
//
//    private func saveSelectedStyle() {
//        if let selectedStyle = selectedStyle {
//            UserDefaults.standard.set(selectedStyle.rawValue, forKey: "selectedStyle")
//        }
//    }
//
//    private func saveSelectedIconSize() {
//        if let selectedIconSize = selectedIconSize {
//            UserDefaults.standard.set(selectedIconSize.rawValue, forKey: "selectedIconSize")
//        }
//    }
//
//    private func loadSelectedStyle() -> DirectMenuStyle {
//        if let rawValue = UserDefaults.standard.string(forKey: "selectedStyle") {
//            return DirectMenuStyle(rawValue: rawValue) ?? .brightStyle
//        }
//        return .brightStyle
//    }
//
//    private func loadSelectedIconSize() -> IconSize {
//        if let rawValue = UserDefaults.standard.string(forKey: "selectedIconSize") {
//            return IconSize(rawValue: rawValue) ?? .normal
//        }
//        return .normal
//    }
//
//    // Rest of the code remains the same
//}
//
//struct ListStyleModifier: ViewModifier {
//
//    @ObservedObject var settingsManager: SettingsManager
//
//    var isListStyleVisible: Bool {
//        settingsManager.selectedStyle == .brightStyle
//    }
//
//    func body(content: Content) -> some View {
//        content.listStyle(isListStyleVisible ? InsetGroupedListStyle() : GroupedListStyle())
//    }
//}
//
//struct IconSizeModifier: ViewModifier {
//
//    @ObservedObject var settingsManager: SettingsManager
//
//    func body(content: Content) -> some View {
//        switch settingsManager.selectedIconSize {
//        case .small:
//            return AnyView(content.scaleEffect(0.9))
//        case .normal:
//            return AnyView(content.scaleEffect(1.0))
//        case .large:
//            return AnyView(content.scaleEffect(1.1).padding(.horizontal, 10))
//        }
//    }
//}

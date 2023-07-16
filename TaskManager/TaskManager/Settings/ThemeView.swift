//
//  ThemeView.swift
//  CoreDataTM
//
//  Created by ForMore on 04/07/2023.
//

import SwiftUI

struct ThemeView: View {
    var body: some View {
        Text("Will be availible soon")
            .padding(.top, 50)
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

struct ThemeView_Previews: PreviewProvider {
    static var previews: some View {
        ThemeView()
    }
}

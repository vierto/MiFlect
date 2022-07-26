//
//  SplashScreenView.swift
//  MiFlect
//
//  Created by Vendly on 26/07/22.
//

import SwiftUI

struct SplashScreenView: View {
    
    @State private var isActive = false
    @State private var opacity = 0.5
    
    var body: some View {
        
        if isActive {
            HomeReflection()
        } else {
            VStack {
                VStack {
                    Image("splashScreen")
                        .ignoresSafeArea()
                }
                .opacity(opacity)
                .onAppear {
                    withAnimation(.easeInOut(duration: 1.0)) {
                        self.opacity = 1.0
                    }
                }
            }
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                    self.isActive = true
                }
            }
        }
        
    }
}

struct SplashScreenView_Previews: PreviewProvider {
    static var previews: some View {
        SplashScreenView()
    }
}

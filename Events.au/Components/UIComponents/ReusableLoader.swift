//
//  ReusableLoader.swift
//  Events.au
//
//  Created by Swan Nay Phue Aung on 08/07/2024.
//

import SwiftUI

struct ReusableLoader: View {
    
    let loaderText : String
    @Binding var isLoading : Bool
    @Binding var textLoader : Bool
    
    var body: some View {
        
        VStack(alignment:.center,spacing:50) {
            Circle()
                .trim(from: 0,to: 0.8)
                .stroke(style: StrokeStyle(lineWidth: 8,lineCap: .round))
                .foregroundStyle(Theme.tintColor)
                .rotationEffect(.degrees(isLoading ? 360 : 0))
                .frame(height:100)
                .shadow(color:Theme.tintColor,radius: 5)
            ZStack {
                Text(loaderText)
                    .font(.system(size: 30))
                    .bold()
                    .foregroundStyle(Theme.secondaryTextColor.opacity(0.2))
                HStack(spacing:0) {
                    ForEach(0..<loaderText.count,id: \.self) { index in
                        
                        Text(String(loaderText[loaderText.index(loaderText.startIndex,offsetBy: index)]))
                            .font(.system(size: 30))
                            .bold()
                            .foregroundStyle(LinearGradient(colors: [Theme.tintColor,Color.red], startPoint: .leading, endPoint: .trailing))
                           
                    }
                    
                }
                .mask {
                    
                    Rectangle()
                        .rotation(.init(degrees: 70))
                        .frame(width: 100, height: 100)
                        .offset(x : -250)
                        .offset(x :textLoader ? 500 : 0)
                    
                }
                
            }
            
            
        }
        
        .onAppear {
            //setting the animator values to false after viewDidLoad
            self.isLoading = false
            self.textLoader = false
            withAnimation(.easeInOut(duration: 0.7).repeatForever(autoreverses: false)) {
                self.isLoading.toggle()
            }
            withAnimation(.linear(duration: 2).repeatForever(autoreverses: false)) {
                self.textLoader.toggle()
            }
        }
    }
}

#Preview {
    ReusableLoader(loaderText: "Switching Roles...",isLoading: .constant(true),textLoader: .constant(true))
        .padding()
}

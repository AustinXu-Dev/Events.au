//
//  ContentView.swift
//  Events.au
//
//  Created by Austin Xu on 2024/6/6.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack(spacing:Theme.defaultSpacing) {
            Image(systemName: "globe")
                .imageScale(.large)
            Text("Heading")
                .font(.system(size: Theme.headingFontSize))
                .fontWeight(Theme.headingFontWeight)
            
            Text("Label!")
                .font(.system(size: Theme.labelFontSize))
                .fontWeight(Theme.labelFontWeight)
            
            Text("body")
                .font(.system(size: Theme.bodyFontSize))
                .fontWeight(Theme.bodyFontWeight)
            
            Image(systemName: "bell.circle")
                .font(.system(size:Theme.iconSize))
        
            
            Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                /*@START_MENU_TOKEN@*/Text("Button")/*@END_MENU_TOKEN@*/
                    .foregroundStyle(Theme.primaryText)
            })
            .padding(Theme.padding)
            .background(
                Theme.tintColor
            )
            .cornerRadius(Theme.cornerRadius)
            .shadow(color:Theme.shadowColor,radius: Theme.shadowRadius,x: Theme.shadowX,y:Theme.shadowY)
                      
                
        }
        .padding()
    }
}

#Preview {
    ContentView()
}

//
//  SearchBar.swift
//  Events.au
//
//  Created by Austin Xu on 2024/6/16.
//

import SwiftUI

struct SearchBar: View {
    @Binding var searchText: String
    @Binding var isFiltering: Bool

       var body: some View {
           HStack {
               TextField("Search...", text: $searchText)
                   .padding(7)
                   .padding(.horizontal, 25)
                   .background(Color(.systemGray6))
                   .cornerRadius(8)
                   .overlay(
                       HStack {
                           Image(systemName: "magnifyingglass")
                               .foregroundColor(.gray)
                               .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                               .padding(.leading, 8)

                           if !searchText.isEmpty {
                               Button(action: {
                                   self.searchText = ""
                               }) {
                                   Image(systemName: "xmark.circle.fill")
                                       .foregroundColor(.gray)
                                       .padding(.trailing, 8)
                               }
                           }
                       }
                   )
//                   .padding(.horizontal, 10)

               Button(action: {
                   isFiltering.toggle()
               }) {
                   RoundedRectangle(cornerRadius: 10)
                       .frame(width: 40, height: 40)
                       .foregroundStyle(Theme.backgroundColorPink)
                       .overlay {
                           Image(isFiltering ? "filter_icon_active" : "filter_icon")
                               .font(.system(size: 24))
                           
                       }
//                       .padding(.trailing, 10)
                   
               }
           }
           .padding(.vertical, 10)
           .background(Color.white) // Removed the shadow to eliminate grey lines
       }
}

#Preview {
    SearchBar(searchText: .constant("keyword"), isFiltering: .constant(false))
}

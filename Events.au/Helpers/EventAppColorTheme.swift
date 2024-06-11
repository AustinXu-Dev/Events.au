//
//  EventApp + ColorTheme.swift
//  Events.au
//
//  Created by Kelvin Gao  on 8/6/2567 BE.
//

import SwiftUI

struct EventAppColorTheme {
    static let button = Color(red: 238/255, green: 50/255, blue: 62/255);
    static let divider = Color(red: 238/255, green: 42/255, blue: 74/255, opacity: 0.25);
}

extension Color {
    static let eventBackground = EventAppColorTheme.button;
    static let eventDivider = EventAppColorTheme.divider;
}

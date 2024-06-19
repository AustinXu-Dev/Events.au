//
//  AdminProfileColorTheme.swift
//  Events.au
//
//  Created by Kelvin Gao  on 17/6/2567 BE.
//

import SwiftUI

struct AdminProfileColorTheme {
    static let approved = Color(red: 1.0, green: 0.93, blue: 0.878);
    static let pending = Color(red: 0.8745, green: 0.8745, blue: 0.8745);
}

extension Color {
    static let approved = AdminProfileColorTheme.approved;
    static let pending = AdminProfileColorTheme.pending;
}

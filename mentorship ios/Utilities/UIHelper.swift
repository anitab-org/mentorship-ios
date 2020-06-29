//
//  UIHelper.swift
//  Created on 21/06/20
//  Created for AnitaB.org Mentorship-iOS 
//

import SwiftUI

class UIHelper {
    //helper for Home Screen relations list
    struct HomeScreen {
        struct RelationsListData {
            let relationTitle = [
                "Pending",
                "Accepted",
                "Rejected",
                "Cancelled",
                "Completed"
            ]
            let relationImageName = [
                ImageNameConstants.SFSymbolConstants.pending,
                ImageNameConstants.SFSymbolConstants.accepted,
                ImageNameConstants.SFSymbolConstants.rejected,
                ImageNameConstants.SFSymbolConstants.cancelled,
                ImageNameConstants.SFSymbolConstants.completed
            ]
            let relationImageColor: [Color] = [
                DesignConstants.Colors.pending,
                DesignConstants.Colors.accepted,
                DesignConstants.Colors.rejected,
                DesignConstants.Colors.cancelled,
                DesignConstants.Colors.defaultIndigoColor
            ]
            var relationCount = [0, 0, 0, 0, 0]
        }
    }
    
    //views for section 1 settings navigation destination
    let settingsViews: [AnyView] = [
        AnyView(About()), AnyView(Text("Feedback")), AnyView(ChangePassword())
    ]
}

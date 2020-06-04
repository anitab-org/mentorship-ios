//
//  DesignConstants.swift
//  mentorship ios
//
//  Created by Yugantar Jain on 04/06/20.
//  Copyright © 2020 Yugantar Jain. All rights reserved.
//

import SwiftUI


struct DesignConstants {
    
    struct Spacing {
        static let bigSpacing: CGFloat = 45
        static let smallSpacing: CGFloat = 15
        static let minimalSpacing: CGFloat = 5
    }
    
    struct Padding {
        //used to expand frame, eg. of textfield
        static let frameExpansionPadding: CGFloat = 10
        
        // default SwiftUI padding value = 16. Used for screen margins
        static let topPadding: CGFloat = 16
        static let bottomPadding: CGFloat = 16
        static let leadingPadding: CGFloat = 16
        static let trailingPadding: CGFloat = 16
    }
    
    struct CornerRadius {
        static let preferredCornerRadius: CGFloat = 5
    }
    
    struct Opacity {
        static let disabledViewOpacity: Double = 0.75
        static let tapHighlightingOpacity: Double = 0.75
    }
    
    struct Colors {
        static let defaultIndigoColor = Color(.systemIndigo)
        static let secondaryBackground = Color(.secondarySystemBackground)
    }
    
}

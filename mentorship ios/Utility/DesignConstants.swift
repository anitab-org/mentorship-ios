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
        static let bigSpacing: CGFloat = 48
        static let smallSpacing: CGFloat = 16
        static let minimalSpacing: CGFloat = 6
    }
    
    struct Screen {
        struct Padding {
            // default SwiftUI padding value = 16
            static let topPadding: CGFloat = 16
            static let bottomPadding: CGFloat = 16
            static let leadingPadding: CGFloat = 16
            static let trailingPadding: CGFloat = 16
        }
    }
    
    struct Form {
        struct Spacing {
                static let bigSpacing: CGFloat = 46
                static let smallSpacing: CGFloat = 16
                static let minimalSpacing: CGFloat = 6
        }
    }
    
    struct Padding {
        //used to expand frame, eg. of textfield
        static let frameExpansionPadding: CGFloat = 10
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

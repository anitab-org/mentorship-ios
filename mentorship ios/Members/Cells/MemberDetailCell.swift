//
//  MemberDetailCell.swift
//  mentorship ios
//
//  Created by Yugantar Jain on 09/06/20.
//  Copyright © 2020 Yugantar Jain. All rights reserved.
//

import SwiftUI

struct MemberDetailCell: View {
    let title: String
    let value: String?

    var body: some View {
        if !(value?.isEmpty ?? true) {
            return AnyView(
                HStack {
                    Text(title).font(.subheadline)
                        .frame(width: DesignConstants.Width.listCellTitle)
                        .multilineTextAlignment(.center)
                    Divider()
                    Text(value ?? "-").font(.headline)
                }
            )
        } else {
            return AnyView(
                EmptyView()
            )
        }
    }
}

struct MemberDetailCell_Previews: PreviewProvider {
    static var previews: some View {
        MemberDetailCell(title: "title", value: "value")
    }
}

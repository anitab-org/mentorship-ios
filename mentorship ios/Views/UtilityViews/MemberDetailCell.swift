//
//  MemberDetailCell.swift
//  Created on 09/06/20.
//  Created for AnitaB.org Mentorship-iOS
//

import SwiftUI

struct MemberDetailCell: View {
    let type: LocalizableStringConstants.ProfileKeys
    let value: String?
    let hideEmptyFields: Bool

    var body: some View {
        guard !(value?.isEmpty ?? true) || !hideEmptyFields else {
            return AnyView(EmptyView())
        }
        return AnyView(
            HStack {
                Text(type.rawValue).font(.subheadline)
                    .frame(width: DesignConstants.Width.listCellTitle)
                    .multilineTextAlignment(.center)
                Divider()
                Text(value?.isEmpty ?? false ? "-" : value ?? "-").font(.headline)
            }
        )
    }
}

struct MemberDetailCell_Previews: PreviewProvider {
    static var previews: some View {
        MemberDetailCell(type: .bio, value: "value", hideEmptyFields: true)
    }
}

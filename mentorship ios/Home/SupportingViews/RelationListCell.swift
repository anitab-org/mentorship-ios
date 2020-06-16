//
//  RelationCell.swift
//  Created on 12/06/20.
//  Created for AnitaB.org Mentorship-iOS
//

import SwiftUI

struct RelationListCell: View {
    var systemImageName: String
    var imageColor: Color
    var title: String
    var count: Int

    var body: some View {
        HStack {
            Image(systemName: systemImageName)
                .foregroundColor(imageColor)
                .padding(.trailing, DesignConstants.Padding.insetListCellFrameExpansion)
                .font(.system(size: DesignConstants.Fonts.Size.insetListIcon))

            Text(title)
                .font(.subheadline)

            Spacer()

            Text(String(count))
                .font(.subheadline)
        }
    }
}

struct RelationCell_Previews: PreviewProvider {
    static var previews: some View {
        RelationListCell(systemImageName: "xmark.circle.fill", imageColor: .blue, title: "Accepted", count: 10)
    }
}

//
//  DetailListCell.swift
//  Created on 17/06/20
//  Created for AnitaB.org Mentorship-iOS 
//

import SwiftUI

struct DetailListCell: View {
    var requestData: HomeModel.HomeResponseData.RequestStructure
    var index: Int

    var endDate: Date {
        return Date(timeIntervalSince1970: requestData.endDate ?? 0)
    }

    var body: some View {
        VStack(alignment: .leading, spacing: DesignConstants.Form.Spacing.smallSpacing) {
            HStack {
                Text("Mentee: \(requestData.mentee?.userName ?? "-")")
                Spacer()
                Text("Mentor: \(requestData.mentor?.userName ?? "-")")
            }
            .font(.subheadline)
            .foregroundColor(DesignConstants.Colors.defaultIndigoColor)

            Text(!requestData.notes!.isEmpty ? requestData.notes! : "No Note Present")
                .font(.headline)
                .opacity(requestData.notes!.isEmpty ? DesignConstants.Opacity.disabledViewOpacity / 2 : 1.0)

            Text("End Date: \(DesignConstants.DateFormat.mediumDate.string(from: endDate))")
                .font(.caption)
        }
        .padding(.vertical)
    }
}

//
//  DetailListCellViewModel.swift
//  Created on 22/07/20
//  Created for AnitaB.org Mentorship-iOS 
//

import Foundation
import Combine

class DetailListCellViewModel: ObservableObject {
    var requestData: RequestStructure
    var endDate: String
    
    init(data: RequestStructure) {
        requestData = data
        endDate = DesignConstants.DateFormat.mediumDate.string(from: Date(timeIntervalSince1970: requestData.endDate ?? 0))
    }
}

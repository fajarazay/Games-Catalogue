//
//  DateUtil.swift
//  Games Catalogue
//
//  Created by Fajar Septian on 17/08/21.
//  Copyright ©2021 Fajar Septian. All rights reserved.
//

import Foundation

extension String {
    
    var getFormattedDate: String {
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = "yyyy-MM-dd"
        guard let showDate = inputFormatter.date(from: self ) else { return "-" }
        inputFormatter.dateFormat = "EEEE, dd MMM yyyy"
        let resultString = inputFormatter.string(from: showDate)
        
        return resultString
    }
}

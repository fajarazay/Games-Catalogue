//
//  String+Localization.swift
//  Common
//
//  Created by Fajar Septian on 26/09/21.
//  Copyright ©2021 Fajar Septian. All rights reserved.
//

import Foundation

extension String {
  public func localized(identifier: String) -> String {
    let bundle = Bundle(identifier: identifier) ?? .main
    return bundle.localizedString(forKey: self, value: nil, table: nil)
  }
}

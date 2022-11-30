//
//  Extensions.swift
//  Netflix Clone
//
//  Created by Oliwier Kasprzak on 24/11/2022.
//

import Foundation


extension String {
    func capitalizedFirstLetter() -> String {
        return self.prefix(1).uppercased() + self.lowercased().dropFirst()
    }
}

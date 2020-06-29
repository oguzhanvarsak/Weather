//
//  StoryboardEditor.swift
//  Weather App
//
//  Created by Oğuzhan Varsak on 28.06.2020.
//  Copyright © 2020 Oğuzhan Varsak. All rights reserved.
//

import UIKit
import Foundation

class StoryboardEditor {
    func editWeatherIcons(dayIDInt: Int) -> String {
        switch dayIDInt {
            case 200..<233:
                let imageID = "11d"
                return imageID
            case 500..<532:
                let imageID = "10d"
                return imageID
            case 600..<623:
                let imageID = "13d"
                return imageID
            case 701..<782:
                let imageID = "50d"
                return imageID
            case 800:
                let imageID = "01d"
                return imageID
            case 801..<805:
                let imageID = "03d"
                return imageID
            default:
                let imageID = "03d"
                return imageID
        }
    }
}

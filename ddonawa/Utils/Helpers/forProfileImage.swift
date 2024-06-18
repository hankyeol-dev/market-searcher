//
//  genProfileImageArray.swift
//  ddonawa
//
//  Created by 강한결 on 6/14/24.
//

import UIKit

func _genProfileImageArray() -> [ProfileImage] {
    return UIImage.profile.allCases.enumerated().map { (idx, v) in
        ProfileImage(id: idx, sourceName: v.rawValue)
    }
}

func _getProfileImageById(_ id: Int) -> ProfileImage {
    return _filter(_genProfileImageArray(), {
        $0.id == id
    })[0]
}

func _mappingProfileImageArrayBySelectedId(_ id: Int) -> [ProfileImage] {
    let selected = _getProfileImageById(id)
    
    var array = _filter(_genProfileImageArray(), {
        $0.id != id
    })

    array.insert(selected, at: id)
    
    return array
}

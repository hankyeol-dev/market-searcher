//
//  genProfileImageArray.swift
//  ddonawa
//
//  Created by 강한결 on 6/14/24.
//

import UIKit

func genProfileImageArray() -> [ProfileImage] {
    return UIImage.profile.allCases.enumerated().map { (idx, v) in
        ProfileImage(id: idx, sourceName: v.rawValue)
    }
}

func getProfileImageById(_ id: Int) -> ProfileImage {
    return _filter(genProfileImageArray(), {
        $0.id == id
    })[0]
}

func mappingProfileImageArrayBySelectedId(_ id: Int) -> [ProfileImage] {
    var selected = getProfileImageById(id)
    
    var array = _filter(genProfileImageArray(), {
        $0.id != id
    })

    array.insert(selected, at: id)
    
    return array
}

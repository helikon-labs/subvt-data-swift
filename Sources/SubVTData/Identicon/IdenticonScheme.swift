//
//  IdenticonScheme.swift
//  
//
//  Created by Kutsal Kaan Bilgin on 29.07.2022.
//

struct IdenticonScheme {
    let colors: [UInt]
    let freq: UInt
}

extension IdenticonScheme {
    static let target = IdenticonScheme(
        colors: [0, 28, 0, 0, 28, 0, 0, 28, 0, 0, 28, 0, 0, 28, 0, 0, 28, 0, 1],
        freq: 1
    )
    
    static let cube = IdenticonScheme(
        colors: [0, 1, 3, 2, 4, 3, 0, 1, 3, 2, 4, 3, 0, 1, 3, 2, 4, 3, 5],
        freq: 20
    )
    
    static let quazar = IdenticonScheme(
        colors: [1, 2, 3, 1, 2, 4, 5, 5, 4, 1, 2, 3, 1, 2, 4, 5, 5, 4, 0],
        
        freq: 16)

    static let flower = IdenticonScheme(
        colors: [0, 1, 2, 0, 1, 2, 0, 1, 2, 0, 1, 2, 0, 1, 2, 0, 1, 2, 3],
        freq: 32
    )

    static let cyclic = IdenticonScheme(
        colors: [0, 1, 2, 3, 4, 5, 0, 1, 2, 3, 4, 5, 0, 1, 2, 3, 4, 5, 6],
        freq: 32
    )

    static let vmirror = IdenticonScheme(
        colors: [0, 1, 2, 3, 4, 5, 3, 4, 2, 0, 1, 6, 7, 8, 9, 7, 8, 6, 10],
        freq: 128
    )

    static let hmirror = IdenticonScheme(
        colors: [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 8, 6, 7, 5, 3, 4, 2, 11],
        freq: 128
    )

    static let all: [IdenticonScheme] = [
        .target,
        .cube,
        .quazar,
        .flower,
        .cyclic,
        .vmirror,
        .hmirror
    ]
}

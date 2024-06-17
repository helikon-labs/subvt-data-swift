//
//  Logging.swift
//  
//
//  Created by Kutsal Kaan Bilgin on 24.06.2022.
//

import SwiftyBeaver

let log = logger()

fileprivate func logger() -> SwiftyBeaver.Type  {
    let log = SwiftyBeaver.self
    let console = ConsoleDestination()
    if !log.destinations.contains(console) {
        log.addDestination(console)
    }
    return log
}

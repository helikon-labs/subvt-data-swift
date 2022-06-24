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
    log.addDestination(ConsoleDestination())
    return log
}

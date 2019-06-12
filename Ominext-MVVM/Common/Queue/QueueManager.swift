//
//  QueueManager.swift
//
//  Copyright © 2019 Ominext. All rights reserved.
//

import Foundation
import RxSwift
class QueueManager {
    static let shared = QueueManager()
    
    var serialSchedule: ImmediateSchedulerType!
    
    init() {
        serialSchedule = SerialDispatchQueueScheduler(internalSerialQueueName: "com.omi.rx.serial")
    }
}

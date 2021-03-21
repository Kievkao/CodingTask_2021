//
//  AtomicDict.swift
//  CodingChallenge
//
//  Created by Andrii Kravchenko on 28.01.21.
//

import Foundation

class AtomicDict<Key: Hashable, Value> {
    private var dictStorage = [Key: Value]()

    private let queue = DispatchQueue(
        label: "com.kievkao.\(UUID().uuidString)",
        qos: .utility,
        attributes: .concurrent,
        autoreleaseFrequency: .inherit,
        target: .global()
    )

    subscript(key: Key) -> Value? {
        get { queue.sync { dictStorage[key] }}
        set { queue.async(flags: .barrier) { [weak self] in self?.dictStorage[key] = newValue } }
  }
}

//
//  Sequence+Extensions.swift
//  Healios
//
//  Created by Kristijan Rozankovic on 26/03/2021.
//

import Foundation

extension Sequence {

    /**
     Returns a dictionary containing the elements from the given sequence indexed
     by the key returned from keySelector function applied to each element.

     - Parameter keySelector: Delegate for extracting dictionary key from given element.
     - Returns: Dictionary of elements organized by provided key
    */
    func associateBy<K>(keySelector: (Element) -> K) -> [K: Element] {
        return self.reduce(into: [:]) { (dict, element) in
            dict[keySelector(element)] = element
        }
    }

}

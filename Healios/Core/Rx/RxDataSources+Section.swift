//
//  RxDataSources+Section.swift
//  Healios
//
//  Created by Kristijan Rozankovic on 26/03/2021.
//

import RxDataSources
import RxSwift

class Section<T>: SectionModelType {
    var header: String?
    var items: [T]

    init(items: [T]) {
        self.items = items
    }

    required init(original: Section<T>, items: [T]) {
        self.items = items
    }

    var identity: String {
        return header ?? ""
    }

}

extension Observable {

    func mapToSection<T>() -> Observable<[Section<T>]> where Element == [T] {
        return map { [Section<T>(items: $0)] }
    }

}


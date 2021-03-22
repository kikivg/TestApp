//
//  Factory.swift
//  Healios
//
//  Created by Kristijan Rozankovic on 22/03/2021.
//

import Dip

class Factory<T>: AutoInjectedPropertyBox {

    static var wrappedType: Any.Type { return T.self }
    private var container: DependencyContainer!

    func resolve(_ container: DependencyContainer) throws {
        self.container = container
    }

    func create() -> T {
        return try! container.resolve() as T
    }

    func create(with tag: DependencyTagConvertible) -> T {
        return try! container.resolve(tag: tag) as T
    }

    func create<A>(tag: DependencyTagConvertible, argument: A) -> T {
        return try! container.resolve(tag: tag, arguments: argument) as T
    }

    func create<A>(withArguments arguments: A) -> T {
        return try! container.resolve(arguments: arguments) as T
    }

    func create<A, B>(firstArgument: A, secondArgument: B) -> T {
        return try! container.resolve(arguments: firstArgument, secondArgument) as T
    }

    func create<A, B>(tag: DependencyTagConvertible, firstArgument: A, secondArgument: B) -> T {
        return try! container.resolve(tag: tag, arguments: firstArgument, secondArgument) as T
    }

}

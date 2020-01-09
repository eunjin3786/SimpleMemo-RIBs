//
//  LoggedOutBuilder.swift
//  SimpleMemo
//
//  Created by eunjin on 2020/01/09.
//  Copyright © 2020 eunjin. All rights reserved.
//

import RIBs

protocol LoggedOutDependency: Dependency {
    // TODO: Declare the set of dependencies required by this RIB, but cannot be
    // created by this RIB.
}

final class LoggedOutComponent: Component<LoggedOutDependency> {

    // TODO: Declare 'fileprivate' dependencies that are only used by this RIB.
}

// MARK: - Builder

protocol LoggedOutBuildable: Buildable {
    func build(withListener listener: LoggedOutListener) -> LoggedOutRouting
}

final class LoggedOutBuilder: Builder<LoggedOutDependency>, LoggedOutBuildable {

    override init(dependency: LoggedOutDependency) {
        super.init(dependency: dependency)
    }

    func build(withListener listener: LoggedOutListener) -> LoggedOutRouting {
        let component = LoggedOutComponent(dependency: dependency)
        let viewController = LoggedOutViewController()
        let interactor = LoggedOutInteractor(presenter: viewController)
        interactor.listener = listener
        return LoggedOutRouter(interactor: interactor, viewController: viewController)
    }
}

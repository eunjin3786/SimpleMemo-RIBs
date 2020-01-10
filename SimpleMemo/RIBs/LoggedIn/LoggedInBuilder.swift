//
//  LoggedInBuilder.swift
//  SimpleMemo
//
//  Created by Jinny on 2020/01/10.
//  Copyright © 2020 eunjin. All rights reserved.
//

import RIBs

protocol LoggedInDependency: Dependency {
    // TODO: Make sure to convert the variable into lower-camelcase.
    var LoggedInViewController: LoggedInViewControllable { get }
    // TODO: Declare the set of dependencies required by this RIB, but won't be
    // created by this RIB.
}

final class LoggedInComponent: Component<LoggedInDependency> {

    // TODO: Make sure to convert the variable into lower-camelcase.
    fileprivate var LoggedInViewController: LoggedInViewControllable {
        return dependency.LoggedInViewController
    }

    // TODO: Declare 'fileprivate' dependencies that are only used by this RIB.
    let email: String
    let password: String
    
    init(dependency: LoggedInDependency, email: String, password: String) {
        self.email = email
        self.password = password
        super.init(dependency: dependency)
    }
}

// MARK: - Builder

protocol LoggedInBuildable: Buildable {
    func build(withListener listener: LoggedInListener,
               email: String,
               password: String) -> LoggedInRouting
}

final class LoggedInBuilder: Builder<LoggedInDependency>, LoggedInBuildable {

    override init(dependency: LoggedInDependency) {
        super.init(dependency: dependency)
    }

    func build(withListener listener: LoggedInListener,
               email: String,
               password: String) -> LoggedInRouting {
        let component = LoggedInComponent(dependency: dependency,
                                          email: email,
                                          password: password)
        let interactor = LoggedInInteractor()
        interactor.listener = listener
        return LoggedInRouter(interactor: interactor, viewController: component.LoggedInViewController)
    }
}

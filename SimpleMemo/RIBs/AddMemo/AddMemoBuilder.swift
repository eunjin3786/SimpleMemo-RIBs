import RIBs

protocol AddMemoDependency: Dependency {
    // TODO: Declare the set of dependencies required by this RIB, but cannot be
    // created by this RIB.
}

final class AddMemoComponent: Component<AddMemoDependency> {

    // TODO: Declare 'fileprivate' dependencies that are only used by this RIB.
}

// MARK: - Builder

protocol AddMemoBuildable: Buildable {
    func build(withListener listener: AddMemoListener) -> AddMemoRouting
}

final class AddMemoBuilder: Builder<AddMemoDependency>, AddMemoBuildable {

    override init(dependency: AddMemoDependency) {
        super.init(dependency: dependency)
    }

    func build(withListener listener: AddMemoListener) -> AddMemoRouting {
        let component = AddMemoComponent(dependency: dependency)
        let viewController = AddMemoViewController()
        let interactor = AddMemoInteractor(presenter: viewController)
        interactor.listener = listener
        return AddMemoRouter(interactor: interactor, viewController: viewController)
    }
}

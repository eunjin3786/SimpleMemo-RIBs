import RIBs
import RxSwift

class RIBTreeViewer {
    
    private let rootRouter: Routing
    private let monitoringIntervalMilliseconds: Int
    private var monitoringDisposable: Disposable?
    
    private let disposeBag = DisposeBag()
    
    init(rootRouter: Routing, monitoringIntervalMilliseconds: Int = 1000) {
        self.rootRouter = rootRouter
        self.monitoringIntervalMilliseconds = monitoringIntervalMilliseconds
    }
    
    func startObserveTree() {
        monitoringDisposable = Observable<Int>.interval(.milliseconds(monitoringIntervalMilliseconds), scheduler: MainScheduler.instance)
        .map { [unowned self] _ in
            self.tree(router: self.rootRouter)
        }
        .distinctUntilChanged { tree1, tree2 in
            NSDictionary(dictionary: tree1).isEqual(to: tree2)
        }
        .subscribe(onNext: { [weak self] tree in
            self?.printTree(tree)
        })
        
        monitoringDisposable?.disposed(by: disposeBag)
    }
    
    func stopObserveTree() {
        monitoringDisposable?.dispose()
        monitoringDisposable = nil
    }
    
    func getChildren(of router: Routing? = nil) -> [String] {
        if let tree = getTree(from: router)["children"] as? [[String: Any]] {
            return tree.compactMap { $0["name"] as? String }
        } else {
            return []
        }
    }
    
    func getTree(from router: Routing? = nil) -> [String: Any] {
        if let router = router {
            return tree(router: router, needMarkViewableRIB: false)
        } else {
            return tree(router: rootRouter, needMarkViewableRIB: false)
        }
    }
    
    func showTree(from router: Routing? = nil) {
        if let router = router {
            printTree(tree(router: router))
        } else {
            printTree(tree(router: rootRouter))
        }
    }
    
    private func printTree(_ tree: [String: Any]) {
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: tree, options: [.prettyPrinted])
            print("🌳 RIBTree 🌳")
            print(String(data: jsonData, encoding: .utf8) ?? "{}")
        } catch {
            print("🌳 RIBTree dic to json error: \(error) 🌳")
        }
    }
    
    private func tree(router: Routing, needMarkViewableRIB: Bool = true) -> [String: Any] {
        var currentRouter = String(describing: type(of: router))
       
        if needMarkViewableRIB && router is ViewableRouting {
            currentRouter += "(Viewable)"
        }
        
        if router.children.isEmpty {
            return ["name": currentRouter, "children": []]
        } else {
            return ["name": currentRouter, "children": router.children.map { tree(router: $0, needMarkViewableRIB: needMarkViewableRIB) }]
        }
    }
}


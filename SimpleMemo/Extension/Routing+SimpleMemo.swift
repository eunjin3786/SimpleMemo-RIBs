import RIBs

extension Routing {
    
    func log() {
        print("🌳 RIBTree 🌳")
        print(RIBTree.treeLog(rootRouter: self))
    }
}

class RIBTree {
    
    class func treeLog(rootRouter: Routing, depth: Int = 0) -> String {
        
        var text = ""
        
        if depth == 0 {
            text += String(describing: rootRouter)
        } else {
            text += "\n" + String(repeating: "  ", count: depth) + "ㄴ" + String(describing: rootRouter)
        }
            
        if rootRouter is ViewableRouting {
            text += " (Viewable)"
        }
        
        if rootRouter.children.isEmpty {
            return text
        } else {
            text += rootRouter.children
                .map { treeLog(rootRouter: $0, depth: depth + 1) }
                .reduce("", +)
            return text
        }
    }
}

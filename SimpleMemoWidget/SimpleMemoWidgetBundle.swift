import WidgetKit
import SwiftUI

@main
struct SimpleMemoWidgetBundle: WidgetBundle {
    @WidgetBundleBuilder
    var body: some Widget {
        MemoWidget()
        MemoListWidget()
    }
}

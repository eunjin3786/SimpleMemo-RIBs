import WidgetKit
import Foundation

struct MemoListEntry: TimelineEntry {
    var date = Date()
    let memos: [Memo]
}

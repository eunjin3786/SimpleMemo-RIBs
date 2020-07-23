import Foundation
import WidgetKit

struct MemoProvider: TimelineProvider {
    typealias Entry = MemoEntry
    
    func snapshot(with context: Context, completion: @escaping (MemoEntry) -> ()) {
        let memo = Memo(title: "당근주스 먹기")
        let entry = MemoEntry(memo: memo)
        completion(entry)
    }
    
    func timeline(with context: Context, completion: @escaping (Timeline<MemoEntry>) -> ()) {
        let memo = Memo(title: "당근주스 먹기")
        let entries = [MemoEntry(memo: memo)]
        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
}

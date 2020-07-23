import Foundation
import WidgetKit

struct MemoListProvider: TimelineProvider {
    typealias Entry = MemoListEntry
    
    func snapshot(with context: Context, completion: @escaping (MemoListEntry) -> ()) {
        let memo1 = Memo(title: "당근 주스 먹기")
        let memo2 = Memo(title: "케일 주스 먹기")
        let memo3 = Memo(title: "사과 주스 먹기")
        
        let memos = [memo1, memo2, memo3]
        let entry = MemoListEntry(memos: memos)
        completion(entry)
    }
    
    func timeline(with context: Context, completion: @escaping (Timeline<MemoListEntry>) -> ()) {
        let memo1 = Memo(title: "당근 주스 먹기")
        let memo2 = Memo(title: "케일 주스 먹기")
        let memo3 = Memo(title: "사과 주스 먹기")
        
        let memos = [memo1, memo2, memo3]
        let entry = MemoListEntry(memos: memos)
        let entries = [entry]
        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
}

import SwiftUI

struct MemoListEntryView: View {
    
    let entry: MemoListEntry
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct MemoListEntryView_Previews: PreviewProvider {
    static var previews: some View {
        let memoListEntry = MemoListEntry(memos: [
            Memo(title: "아메리카노 사기"),
            Memo(title: "아메리카노 사기"),
            Memo(title: "아메리카노 사기")
        ])
        return MemoListEntryView(entry: memoListEntry)
    }
}

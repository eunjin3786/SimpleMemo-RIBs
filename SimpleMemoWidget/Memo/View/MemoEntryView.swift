import SwiftUI

struct MemoEntryView: View {
    
    let entry: MemoEntry
    
    var body: some View {
        VStack {
            Text(entry.memo.title)
                .font(.custom("AppleSDGothicNeo-Bold", size: 16))
                .foregroundColor(.blue)
        }.padding(.all, 16)
    }
}

struct MemoEntryView_Previews: PreviewProvider {
    static var previews: some View {
        let entry = MemoEntry(memo: Memo(title: "아메리카노 사기"))
        return MemoEntryView(entry: entry)
    }
}

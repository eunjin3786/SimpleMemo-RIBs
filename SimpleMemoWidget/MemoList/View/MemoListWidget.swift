import WidgetKit
import SwiftUI

struct MemoListWidget: Widget {
    private let kind: String = "MemoListWidget"

    public var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind,
                            provider: MemoProvider(),
                            placeholder: MemoPlaceholderView()) { entry in
            MemoEntryView(entry: entry)
        }
        .configurationDisplayName("메모 리스트 위젯")
        .description("메모 리스트를 보여줍니다.")
    }
}

struct MemoListWidget_Previews: PreviewProvider {
    static var previews: some View {
        /*@START_MENU_TOKEN@*/Text("Hello, World!")/*@END_MENU_TOKEN@*/
    }
}



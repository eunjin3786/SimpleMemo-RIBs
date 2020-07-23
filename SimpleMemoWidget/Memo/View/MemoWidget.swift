import WidgetKit
import SwiftUI

struct MemoWidget: Widget {
    private let kind: String = "MemoWidget"

    public var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind,
                            provider: MemoProvider(),
                            placeholder: MemoPlaceholderView()) { entry in
            MemoEntryView(entry: entry)
        }
        .configurationDisplayName("메모 위젯")
        .description("메모가 2초마다 넘어갑니다")
    }
}

struct MemoWidget_Previews: PreviewProvider {
    static var previews: some View {
        /*@START_MENU_TOKEN@*/Text("Hello, World!")/*@END_MENU_TOKEN@*/
    }
}


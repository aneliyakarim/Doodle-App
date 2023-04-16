import SwiftUI

struct DetailView: View {
    let item: Item
    
    var body: some View {
        AsyncImage(url: item.url) { image in
            DrawingView(image: image)
 } placeholder: {
            ProgressView()
        }
    }
}

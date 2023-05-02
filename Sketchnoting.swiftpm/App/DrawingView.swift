import SwiftUI
import PencilKit

struct DrawingView: View {
    var image: Image
    @State private var showingAlert = false
    @State private var pkCanvasView = PKCanvasView()
    
    var body: some View {
        
        ZStack {
            RoundedRectangle(cornerRadius: 20)
                .foregroundColor(.white)
                .shadow(color: Color(red: 0.8, green: 0.8, blue: 0.8, opacity: 0.5), radius: 8)
            image
                .resizable()
                .scaledToFit()
                .opacity(0.3)
            
            GeometryReader { geo in
                PKCanvas(canvasView: $pkCanvasView)
                    .frame(width: geo.size.width, height: geo.size.height)
                    .cornerRadius(20)
                
                VStack(alignment: .trailing) {
                    Spacer()
                    HStack {
                        Button {
                            let image = pkCanvasView.drawing.image(from: pkCanvasView.bounds, scale: UIScreen.main.scale)
                            UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
                            showingAlert = true
                        }
                    label: {
                        Image(systemName: "square.and.arrow.up")
                    }
                    .foregroundColor(.black)
                    .font(.system(size: 20, weight: .bold))
                    .opacity(1)
                    .alert(isPresented: $showingAlert) {
                        Alert(title: Text("Doodle ✏️"), message: Text("Your Doodle is saved in Photos."), dismissButton: .default(Text("Got it!")))
                    }
                        Spacer()
                        
                    }
                    .padding(20)
                    .background(.white.opacity(0.5))
                    .cornerRadius(20)
                    .padding(20)
                    
                }
            }
        }
        .padding(50)
    }
}

struct DrawingView_Previews: PreviewProvider {
    static var previews: some View {
        DrawingView(image: Image("frames"))
    }
}



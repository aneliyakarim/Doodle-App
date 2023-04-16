import SwiftUI

struct DrawingView: View {
    var image: Image
    @State var value: [Line] = [Line(points: [CGPoint(), CGPoint()], color: Color.black, lineWidth: 5)]
    @State private var penColor = Color.black
    private var penColors: [Color] {
        return [.pink,
                .red,
                .orange,
                .green,
                .blue,
                .teal,
                .brown,
                .black]
    }
    
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
                let canvas = Canvas { context, size in
                    for line in value {
                        var path = Path()
                        path.addLines(line.points)
                        context.stroke(path, with: .color(line.color), lineWidth: line.lineWidth)
                    }
                }
                    .frame(width: geo.size.width, height: geo.size.height)
                    .cornerRadius(20)
                    .gesture(DragGesture(minimumDistance: 0, coordinateSpace: .local).onChanged({ line in
                        let newPoint = line.location
                        if line.translation.width + line.translation.height == 0 {
                            value.append(Line(points: [newPoint], color: penColor, lineWidth: 5))
                        } else {
                            let index = value.count - 1
                            value[index].points.append(newPoint)
                        }
                    }))
                
                
                canvas

                VStack(alignment: .trailing) {
                    
                    Spacer()
                    HStack {
                        Button {
                            let renderer = ImageRenderer(content: canvas)
                            
                            guard let image = renderer.uiImage else {
                                return
                            }
                            
                            UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
                        }
                    label: {
                        Image(systemName: "square.and.arrow.up")
                    }
                    .foregroundColor(.black)
                    .font(.system(size: 20, weight: .bold))
                    .opacity(value.isEmpty ? 0.3 : 1)
                        Spacer()
                        ForEach(penColors, id:\.self) { color in
                            Button {
                                penColor = color
                            } label: {
                                Image(systemName: penColor == color ? "circle.fill" : "circle")
                                    .font(.system(size: 20))
                                    .foregroundColor(color)
                            }
                        }
                        Spacer()
                        Button {
                            value.removeLast()
                            while let lastLine = value.last {
                                if lastLine.points.count <= 1 {
                                    value.removeLast()
                                } else {
                                    break
                                }
                            }
                        } label: {
                            Image(systemName: "arrow.uturn.backward")
                                .foregroundColor(.black)
                                .font(.system(size: 20, weight: .bold))
                                .opacity(value.isEmpty ? 0.3 : 1)
                        }
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

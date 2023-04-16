import SwiftUI

@main
struct MySketchnotingApp: App {
    @StateObject var dataModel = DataModel()
    
    var body: some Scene {
        WindowGroup { 
            NavigationStack {
                GridView()
            }
            .environmentObject(dataModel)
            .navigationViewStyle(.stack)
        }
    }
}

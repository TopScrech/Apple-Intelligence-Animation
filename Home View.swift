import SwiftUI

struct HomeView: View {
    @State private var isFullScreenPresented = false
    
    var body: some View {
        VStack {
            Button("Present Full Screen Sheet") {
                isFullScreenPresented = true
            }
            .fullScreenCover(isPresented: $isFullScreenPresented) {
                ContentView()
            }
        }
    }
}

#Preview {
    HomeView()
}

import SwiftUI

struct PhoneBackground: View {
    @Binding var state: SiriState
    @Binding var origin: CGPoint
    @Binding var counter: Int
    
    private var scrimOpacity: Double {
        switch state {
        case .none: 0
        case .thinking: 0.8
        }
    }
    
    private var iconName: String {
        switch state {
        case .none:
            "mic"
            
        case .thinking:
            "pause"
        }
    }
    
    var body: some View {
        ZStack {
            Image("Background", bundle: .main)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .scaleEffect(1.2) // avoids clipping
                .ignoresSafeArea()
            
            Rectangle()
                .fill(.black)
                .opacity(scrimOpacity)
                .scaleEffect(1.2) // avoids clipping
            
            VStack {
                welcomeText
                
                siriButtonView
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
            .onPressingChanged { point in
                if let point {
                    origin = point
                    counter += 1
                }
            }
            .padding(.bottom, 64)
        }
    }
    
    @ViewBuilder
    private var welcomeText: some View {
        if state == .thinking {
            Text("What are you looking for?")
                .foregroundStyle(.white)
                .frame(maxWidth: 240, maxHeight: .infinity, alignment: .center)
                .multilineTextAlignment(.center)
                .largeTitle(.bold)
                .animation(.easeInOut(duration: 0.2), value: state)
                .contentTransition(.opacity)
        }
    }
    
    private var siriButtonView: some View {
        Button {
            withAnimation(.easeInOut(duration: 0.9)) {
                switch state {
                case .none:
                    state = .thinking
                    
                case .thinking:
                    state = .none
                }
            }
        } label: {
            Image(systemName: iconName)
                .contentTransition(.symbolEffect(.replace))
                .frame(width: 96, height: 96)
                .foregroundStyle(.white)
                .font(.system(size: 32, weight: .bold, design: .monospaced))
                .background {
                    RoundedRectangle(cornerRadius: 32, style: .continuous)
                        .fill(.gray.opacity(0.1))
                }
        }
    }
}

#Preview(traits: .sizeThatFitsLayout) {
    PhoneBackground(
        state: .constant(.none),
        origin: .constant(CGPoint(x: 0.5, y: 0.5)),
        counter: .constant(0)
    )
}

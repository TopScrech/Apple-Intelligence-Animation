import SwiftUI

struct ContentView: View {
    @State private var state: SiriState = .none
    
    // Ripple animation vars
    @State private var counter = 0
    @State private var origin = CGPoint(x: 0.5, y: 0.5)
    
    // Gradient and masking vars
    @State private var gradientSpeed: Float = 0.03
    @State private var maskTimer: Float = 0
    @State private var timer: Timer?
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                // Colorful animated gradient
                MeshGradientView(maskTimer: $maskTimer, gradientSpeed: $gradientSpeed)
                    .scaleEffect(1.3) // avoids clipping
                    .opacity(containerOpacity)
                
                // Brightness rim on edges
                if state == .thinking {
                    RoundedRectangle(cornerRadius: 52, style: .continuous)
                        .stroke(.white, style: .init(lineWidth: 4))
                        .blur(radius: 4)
                }
                
                // Phone background mock, includes button
                PhoneBackground(state: $state, origin: $origin, counter: $counter)
                    .mask {
                        AnimatedRectangle(size: geometry.size, cornerRadius: 48, t: CGFloat(maskTimer))
                            .scaleEffect(computedScale)
                            .frame(width: geometry.size.width, height: geometry.size.height)
                            .blur(radius: animatedMaskBlur)
                    }
            }
        }
        .ignoresSafeArea()
        .modifier(RippleEffect(at: origin, trigger: counter))
        .onAppear {
            timer = Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true) { _ in
                DispatchQueue.main.async {
                    maskTimer += rectangleSpeed
                }
            }
        }
        .onDisappear {
            timer?.invalidate()
        }
    }
    
    private var computedScale: CGFloat {
        switch state {
        case .none: 1.2
        case .thinking: 1
        }
    }
    
    private var rectangleSpeed: Float {
        switch state {
        case .none: 0
        case .thinking: 0.03
        }
    }
    
    private var animatedMaskBlur: CGFloat {
        switch state {
        case .none: 8
        case .thinking: 28
        }
    }
    
    private var containerOpacity: CGFloat {
        switch state {
        case .none: 0
        case .thinking: 1.0
        }
    }
}

#Preview {
    ContentView()
}

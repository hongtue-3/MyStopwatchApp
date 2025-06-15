import SwiftUI

struct ContentView: View {
    @State private var timeElapsed: TimeInterval = 0
    @State private var timerRunning = false
    @State private var timer: Timer?
    @State private var showDot = false

    var body: some View {
        VStack(spacing: 40) {
            Text(timeString(from: timeElapsed))
                .font(.system(size: 60, design: .monospaced))
                .padding()

            Button(action: {
                if timerRunning {
                    timer?.invalidate()
                    timer = nil
                    timerRunning = false
                    showDot = Int(timeElapsed) % 2 == 0 // Hiện chấm nếu số chẵn
                } else {
                    timerRunning = true
                    showDot = false
                    timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { _ in
                        timeElapsed += 0.1
                    }
                }
            }) {
                Text(timerRunning ? "Dừng" : "Bắt đầu")
                    .font(.title)
                    .padding()
                    .background(timerRunning ? Color.red : Color.green)
                    .foregroundColor(.white)
                    .cornerRadius(12)
            }

            if showDot {
                Text("ấ").font(.system(size: 1)) // Dấu chấm trong chữ “ấ”
                    .opacity(0.01)
            }
        }
        .padding()
    }

    func timeString(from time: TimeInterval) -> String {
        let totalSeconds = Int(time)
        let minutes = totalSeconds / 60
        let seconds = totalSeconds % 60
        let milliseconds = Int((time - TimeInterval(totalSeconds)) * 100)
        return String(format: "%02d:%02d.%02d", minutes, seconds, milliseconds)
    }
}

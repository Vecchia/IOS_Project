import SwiftUI
import ThemeKit
import TimerKit

struct MeetingHeaderView: View {
    let secondsElapsed: Int
    let secondsRemaining: Int
    let theme: Theme
    
    private var totalSeconds: Int {
        secondsElapsed + secondsRemaining
    }
    private var progress: Double {
        guard totalSeconds > 0 else { return 1 }
        return Double(secondsElapsed) / Double(totalSeconds)
    }
    private var minutesRemaining: Int {
        secondsRemaining / 60
    }
    
    var body: some View {
        VStack {
            ProgressView(value: progress)
                .progressViewStyle(ScrumProgressViewStyle(theme: theme))
                .scaleEffect(1.2)
            HStack {
                VStack(alignment: .leading) {
                    Text("Tempo Trascorso")
                        .font(.caption)
                        .fontWeight(.semibold)
                    Label("\(secondsElapsed)", systemImage: "hourglass.bottomhalf.fill")
                        .foregroundColor(.green)
                }
                Spacer()
                VStack(alignment: .trailing) {
                    Text("Tempo Rimanente")
                        .font(.caption)
                        .fontWeight(.semibold)
                    Label("\(secondsRemaining)", systemImage: "hourglass.tophalf.fill")
                        .labelStyle(.trailingIcon)
                        .foregroundColor(.orange)
                }
            }
        }
        .accessibilityElement(children: .ignore)
        .accessibilityLabel("Tempo rimanente")
        .accessibilityValue("\(minutesRemaining) minuti")
        .padding([.top, .horizontal])
    }
}
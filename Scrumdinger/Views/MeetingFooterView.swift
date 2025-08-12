import SwiftUI
import TimerKit

struct MeetingFooterView: View {
    let speakers: [ScrumTimer.Speaker]
    var skipAction: ()->Void
    
    private var speakerNumber: Int? {
        guard let index = speakers.firstIndex(where: { !$0.isCompleted }) else { return nil }
        return index + 1
    }
    private var isLastSpeaker: Bool {
        return speakers.dropLast().allSatisfy { $0.isCompleted }
    }
    private var speakerText: String {
        guard let speakerNumber = speakerNumber else { return "Sessione completata! 🎉" }
        return "Partecipante \(speakerNumber) di \(speakers.count)"
    }
    
    var body: some View {
        VStack {
            HStack {
                if isLastSpeaker {
                    Text("Ultimo Partecipante")
                        .fontWeight(.bold)
                        .foregroundColor(.orange)
                } else {
                    Text(speakerText)
                        .fontWeight(.semibold)
                    Spacer()
                    Button(action: skipAction) {
                        Image(systemName: "forward.fill")
                            .font(.title2)
                    }
                    .accessibilityLabel("Prossimo partecipante")
                }
            }
        }
        .padding([.bottom, .horizontal])
    }
}
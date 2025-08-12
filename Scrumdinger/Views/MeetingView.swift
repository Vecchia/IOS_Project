import SwiftUI
import TimerKit
import AVFoundation

struct MeetingView: View {
    @Binding var scrum: DailyScrum
    @State var scrumTimer = ScrumTimer()
    private let player = AVPlayer.dingPlayer()

    var body: some View {
        ZStack {
            // Sfondo gradiente
            LinearGradient(
                gradient: Gradient(colors: [
                    scrum.theme.mainColor,
                    scrum.theme.mainColor.opacity(0.6)
                ]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .cornerRadius(20)
            
            VStack {
                MeetingHeaderView(
                    secondsElapsed: scrumTimer.secondsElapsed,
                    secondsRemaining: scrumTimer.secondsRemaining,
                    theme: scrum.theme
                )
                
                ZStack {
                    Circle()
                        .strokeBorder(lineWidth: 24)
                        .foregroundColor(scrum.theme.accentColor.opacity(0.3))
                    
                    VStack {
                        Image(systemName: "person.3.fill")
                            .font(.system(size: 60))
                            .foregroundColor(scrum.theme.accentColor)
                        Text("Focus Mode")
                            .font(.title2)
                            .fontWeight(.bold)
                            .foregroundColor(scrum.theme.accentColor)
                    }
                }
                
                MeetingFooterView(
                    speakers: scrumTimer.speakers,
                    skipAction: scrumTimer.skipSpeaker
                )
            }
        }
        .padding()
        .foregroundColor(scrum.theme.accentColor)
        .onAppear {
            startScrum()
        }
        .onDisappear {
            endScrum()
        }
        .navigationBarTitleDisplayMode(.inline)
    }

    private func startScrum() {
        scrumTimer.reset(lengthInMinutes: scrum.lengthInMinutes, attendeeNames: scrum.attendees.map { $0.name })
        scrumTimer.speakerChangedAction = {
            player.seek(to: .zero)
            player.play()
        }
        scrumTimer.startScrum()
    }

    private func endScrum() {
        scrumTimer.stopScrum()
        let newHistory = History(attendees: scrum.attendees)
        scrum.history.insert(newHistory, at: 0)
    }
}

import SwiftUI

struct DetailView: View {
    @Binding var scrum: DailyScrum
    @State private var editingScrum = DailyScrum.emptyScrum
    @State private var isPresentingEditView = false
    
    var body: some View {
        List {
            Section(header: Text("INFORMAZIONI SESSIONE")) {
                NavigationLink(destination: MeetingView(scrum: $scrum)) {
                    Label("Inizia Sessione", systemImage: "play.circle.fill")
                        .font(.headline)
                        .foregroundColor(.green)
                }
                HStack {
                    Label("Durata", systemImage: "clock.fill")
                        .foregroundColor(.orange)
                    Spacer()
                    Text("\(scrum.lengthInMinutes) minuti")
                        .fontWeight(.semibold)
                }
                .accessibilityElement(children: .combine)
                HStack {
                    Label("Tema", systemImage: "paintbrush.fill")
                        .foregroundColor(.purple)
                    Spacer()
                    Text(scrum.theme.name)
                        .padding(6)
                        .foregroundColor(scrum.theme.accentColor)
                        .background(scrum.theme.mainColor)
                        .cornerRadius(8)
                }
                .accessibilityElement(children: .combine)
            }
            Section(header: Text("PARTECIPANTI")) {
                ForEach(scrum.attendees) { attendee in
                    Label(attendee.name, systemImage: "person.circle.fill")
                        .foregroundColor(.blue)
                }
            }
            Section(header: Text("CRONOLOGIA SESSIONI")) {
                if scrum.history.isEmpty {
                    Label("Nessuna sessione completata", systemImage: "calendar.badge.exclamationmark")
                        .foregroundColor(.gray)
                }
                ForEach(scrum.history) { history in
                    HStack {
                        Image(systemName: "checkmark.seal.fill")
                            .foregroundColor(.green)
                        Text(history.date, style: .date)
                    }
                }
            }
        }
        .navigationTitle(scrum.title)
        .navigationBarTitleDisplayMode(.large)
        .toolbar {
            Button("Modifica") {
                isPresentingEditView = true
                editingScrum = scrum
            }
            .foregroundColor(.indigo)
            .fontWeight(.semibold)
        }
        .sheet(isPresented: $isPresentingEditView) {
            NavigationStack {
                DetailEditView(scrum: $editingScrum, saveEdits: { dailyScrum in
                    scrum = editingScrum
                })
                .navigationTitle(scrum.title)
            }
        }
    }
}
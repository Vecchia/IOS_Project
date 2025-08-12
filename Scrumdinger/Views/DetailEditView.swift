import SwiftUI

struct DetailEditView: View {
    @Binding var scrum: DailyScrum
    let saveEdits: (DailyScrum) -> Void

    @State private var attendeeName = ""
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        Form {
            Section(header: Text("Info Sessione")) {
                TextField("Titolo", text: $scrum.title)
                HStack {
                    Slider(value: $scrum.lengthInMinutesAsDouble, in: 5...120, step: 5) {
                        Text("Durata")
                    }
                    .accessibilityValue("\(scrum.lengthInMinutes) minuti")
                    .accentColor(.indigo)
                    Spacer()
                    Text("\(scrum.lengthInMinutes) min")
                        .fontWeight(.bold)
                        .foregroundColor(.indigo)
                        .accessibilityHidden(true)
                }
                ThemePicker(selection: $scrum.theme)
            }
            Section(header: Text("Partecipanti")) {
                ForEach(scrum.attendees) { attendee in
                    Text(attendee.name)
                        .foregroundColor(.blue)
                }
                .onDelete { indices in
                    scrum.attendees.remove(atOffsets: indices)
                }
                HStack {
                    TextField("Nuovo Partecipante", text: $attendeeName)
                    Button(action: {
                        withAnimation {
                            let attendee = DailyScrum.Attendee(name: attendeeName)
                            scrum.attendees.append(attendee)
                            attendeeName = ""
                        }
                    }) {
                        Image(systemName: "plus.circle.fill")
                            .foregroundColor(.green)
                            .accessibilityLabel("Aggiungi partecipante")
                    }
                    .disabled(attendeeName.isEmpty)
                }
            }
        }
        .toolbar {
            ToolbarItem(placement: .cancellationAction) {
                Button("Annulla") {
                    dismiss()
                }
                .foregroundColor(.red)
            }
            ToolbarItem(placement: .confirmationAction) {
                Button("Fatto") {
                    saveEdits(scrum)
                    dismiss()
                }
                .fontWeight(.bold)
                .foregroundColor(.green)
            }
        }
    }
}
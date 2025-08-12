import SwiftUI

struct CardView: View {
    let scrum: DailyScrum

    var body: some View {
        VStack(alignment: .leading) {
            Text(scrum.title)
                .font(.headline)
                .fontWeight(.bold)
                .accessibilityAddTraits(.isHeader)
            Spacer()
            HStack {
                Label("\(scrum.attendees.count)", systemImage: "person.3.fill")
                    .accessibilityLabel("\(scrum.attendees.count) partecipanti")
                Spacer()
                Label("\(scrum.lengthInMinutes)", systemImage: "timer")
                    .accessibilityLabel("\(scrum.lengthInMinutes) minuti sessione")
                    .labelStyle(.trailingIcon)
            }
            .font(.caption)
            .fontWeight(.medium)
        }
        .padding()
        .foregroundColor(scrum.theme.accentColor)
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(scrum.theme.mainColor.opacity(0.5), lineWidth: 2)
        )
    }
}
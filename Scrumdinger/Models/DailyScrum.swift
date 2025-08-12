import Foundation
import ThemeKit

struct DailyScrum: Identifiable {
    let id: UUID
    var title: String
    var attendees: [Attendee]
    var lengthInMinutes: Int
    var lengthInMinutesAsDouble: Double {
        get {
            Double(lengthInMinutes)
        }
        set {
            lengthInMinutes = Int(newValue)
        }
    }
    var theme: Theme
    var history: [History] = []
    
    init(id: UUID = UUID(), title: String, attendees: [String], lengthInMinutes: Int, theme: Theme) {
        self.id = id
        self.title = title
        self.attendees = attendees.map { Attendee(name: $0) }
        self.lengthInMinutes = lengthInMinutes
        self.theme = theme
    }
}

extension DailyScrum {
    struct Attendee: Identifiable {
        let id: UUID
        var name: String
        
        init(id: UUID = UUID(), name: String) {
            self.id = id
            self.name = name
        }
    }
    
    static var emptyScrum: DailyScrum {
        DailyScrum(title: "", attendees: [], lengthInMinutes: 25, theme: .lavender)
    }
    
    
    static let sampleData: [DailyScrum] = [
        DailyScrum(
            title: " Design Sprint UI/UX",
            attendees: ["Marco Rossi", "Sofia Bianchi", "Alessandro Verdi"],
            lengthInMinutes: 45,
            theme: .lavender
        ),
        DailyScrum(
            title: "Code Review Backend",
            attendees: ["Giulia Ferrari", "Luca Romano", "Elena Conti", "Federico Ricci"],
            lengthInMinutes: 30,
            theme: .seafoam
        ),
        DailyScrum(
            title: " Strategia Marketing Q1",
            attendees: ["Chiara Moretti", "Roberto Marino", "Anna Greco"],
            lengthInMinutes: 60,
            theme: .poppy
        ),
        DailyScrum(
            title: " Lancio Prodotto Beta",
            attendees: ["Team Alpha", "Team Beta", "Direzione", "Marketing"],
            lengthInMinutes: 90,
            theme: .buttercup
        ),
        DailyScrum(
            title: " Brainstorming Creativo",
            attendees: ["Tutto il team", "Consulenti esterni"],
            lengthInMinutes: 25,
            theme: .tan
        ),
        DailyScrum(
            title: " App Testing Session",
            attendees: ["QA Team", "Sviluppatori", "Beta Tester"],
            lengthInMinutes: 40,
            theme: .teal
        ),
        DailyScrum(
            title: " Innovation Workshop",
            attendees: ["R&D", "Product Team", "CEO"],
            lengthInMinutes: 120,
            theme: .indigo
        )
    ]
}
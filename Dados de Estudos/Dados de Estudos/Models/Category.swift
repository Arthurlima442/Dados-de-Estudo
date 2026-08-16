import Foundation

struct Category: Codable {
    let id: String
    let title: String
    let description: String
    let topics: [Topic]
}

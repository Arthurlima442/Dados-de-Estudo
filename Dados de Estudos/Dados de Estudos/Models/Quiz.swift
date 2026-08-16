import Foundation

// MARK: - Quiz
// Representa uma pergunta de quiz

struct Quiz: Codable {
    let id: String                  // "var_1"
    let pergunta: String            // "O que é uma variável?"
    let respostas: [Resposta]       // Array de 4 respostas
}

// MARK: - Resposta
// Representa uma opção de resposta

struct Resposta: Codable {
    let texto: String              // "Um espaço de memória mutável"
    let correta: Bool              // true ou false
}

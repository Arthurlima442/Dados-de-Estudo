import Foundation

// MARK: - StudyContent Model

/// Representa o conteúdo de estudo de um tópico.
///
/// Esta estrutura contém toda a informação que será exibida
/// quando o usuário abrir um tópico para estudar.
///
/// - explanation: Uma explicação clara e objetiva do conceito
/// - example: Um exemplo prático de código
/// - keyPoints: Lista de pontos-chave para memorizar
///
/// Por que separamos assim?
/// Porque cada campo tem um propósito diferente na UI:
/// - explanation vai num texto grande
/// - example vai num card com fundo diferente
/// - keyPoints vai numa lista de bullets
struct StudyContent: Codable {

    // MARK: - Properties

    /// Explicação clara e objetiva do conceito.
    /// Deve ser simples e direto, sem enrolação.
    let explanation: String

    /// Um exemplo prático em forma de código.
    /// Este exemplo será exibido em um card especial.
    let example: String

    /// Lista de pontos-chave para o usuário memorizar.
    /// Deve ser breve e direto (máximo 3-5 pontos).
    let keyPoints: [String]
}

import Foundation

// MARK: - Topic Model

/// Representa um tópico (aula) dentro de uma categoria.
///
/// Cada tópico é uma unidade de aprendizado dentro de uma categoria.
/// Por exemplo: em "Fundamentos", um tópico pode ser "Variáveis".
///
/// Por que tem id?
/// O ID é único para identificar o tópico. Permite:
/// - Marcar tópicos como "estudado" (usando UserDefaults)
/// - Navegar entre tópicos
/// - Salvar o progresso do usuário
struct Topic: Codable {

    // MARK: - Properties

    /// ID único do tópico.
    /// Exemplo: "variaveis", "constantes", "tipos_dados"
    /// Deve ser único dentro de uma categoria.
    let id: String

    /// Título do tópico exibido na lista.
    /// Exemplo: "Variáveis", "Constantes", "Tipos de Dados"
    let title: String

    /// O conteúdo de estudo do tópico.
    /// Contém a explicação, exemplo e pontos-chave.
    let content: StudyContent
}

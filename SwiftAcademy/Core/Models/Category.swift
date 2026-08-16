import Foundation

// MARK: - Category Model

/// Representa uma categoria de estudo.
///
/// Uma categoria é um grupo de tópicos relacionados.
/// Por exemplo: "Fundamentos", "Optionals", "Struct", etc.
///
/// A categoria é a primeira coisa que o usuário vê na tela inicial.
/// Ao clicar nela, ele acessa a lista de tópicos.
struct Category: Codable {

    // MARK: - Properties

    /// ID único da categoria.
    /// Exemplo: "fundamentos", "optionals", "struct"
    /// Deve ser único em toda a app.
    let id: String

    /// Título da categoria exibido na tela inicial.
    /// Exemplo: "Fundamentos", "Optionals", "Struct"
    /// Deve ser legível e claro.
    let title: String

    /// Descrição breve da categoria.
    /// Exemplo: "Conceitos básicos de Swift"
    /// Esta descrição pode ser exibida abaixo do título.
    let description: String

    /// Lista de tópicos dentro desta categoria.
    /// Cada tópico é uma aula/lição que o usuário pode estudar.
    ///
    /// Por que é um array?
    /// Porque uma categoria pode ter vários tópicos.
    /// Exemplo: "Fundamentos" tem "Variáveis", "Constantes", etc.
    let topics: [Topic]
}

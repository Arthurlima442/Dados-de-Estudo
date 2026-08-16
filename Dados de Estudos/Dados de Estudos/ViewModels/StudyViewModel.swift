import Foundation

class StudyViewModel {

    private let topic: Topic

    init(topic: Topic) {
        self.topic = topic
    }

    /// Retorna o título do tópico
    func topicTitle() -> String {
        return topic.title
    }

    /// Retorna a explicação do conceito
    func explanation() -> String {
        return topic.content.explanation
    }

    /// Retorna o exemplo de código
    func example() -> String {
        return topic.content.example
    }

    /// Retorna os pontos-chave do tópico
    func keyPoints() -> [String] {
        return topic.content.keyPoints
    }

    /// Retorna o conteúdo completo do tópico
    func content() -> StudyContent {
        return topic.content
    }
}

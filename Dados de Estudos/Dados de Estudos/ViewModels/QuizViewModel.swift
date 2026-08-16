import Foundation

// MARK: - QuizViewModel
// Gerencia a lógica de um quiz

class QuizViewModel {

    private let dataService: DataServiceProtocol
    var quizzes: [Quiz] = []

    var quizAtual: Int = 0
    var acertos: Int = 0
    var erros: Int = 0

    // Respostas selecionadas (para mostrar resultado)
    var respostaClicada: Int? = nil
    var respostaCerta: Int? = nil
    var mostraResultado: Bool = false

    init(dataService: DataServiceProtocol = DataService()) {
        self.dataService = dataService
    }

    /// Carrega os quizzes do JSON via DataService
    func carregarQuizzes() {
        do {
            let categories = try dataService.loadCategories()
            self.quizzes = try dataService.loadQuizzes()
        } catch {
            self.quizzes = []
        }
    }

    /// Retorna o quiz atual
    func quizAtualExemplo() -> Quiz? {
        guard quizAtual < quizzes.count else { return nil }
        return quizzes[quizAtual]
    }

    /// Retorna quantas perguntas tem no total
    func totalPerguntas() -> Int {
        return quizzes.count
    }

    /// Verifica se a resposta clicada é a correta
    func verificarResposta(_ indexResposta: Int) {
        // Encontra qual é a resposta correta
        if let quizAtualItem = quizAtualExemplo() {
            if let indexCerto = quizAtualItem.respostas.firstIndex(where: { $0.correta }) {
                respostaCerta = indexCerto
                respostaClicada = indexResposta
                mostraResultado = true

                // Incrementa acertos ou erros
                if indexResposta == indexCerto {
                    acertos += 1
                } else {
                    erros += 1
                }
            }
        }
    }

    /// Vai para o próximo quiz
    func proximoQuiz() {
        quizAtual += 1
        respostaClicada = nil
        respostaCerta = nil
        mostraResultado = false
    }

    /// Verifica se chegou ao final
    func chegouAoFinal() -> Bool {
        return quizAtual >= quizzes.count
    }

    /// Calcula a porcentagem de acertos
    func calcularPorcentagem() -> Int {
        let total = acertos + erros
        if total == 0 { return 0 }
        return (acertos * 100) / total
    }

    /// Verifica se passou (80% ou mais)
    func passou() -> Bool {
        return calcularPorcentagem() >= 80
    }
}

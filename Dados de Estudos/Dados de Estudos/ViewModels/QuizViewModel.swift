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

    /// Carrega os quizzes (com dados mockados)
    func carregarQuizzes() {
        // Criar dados mockados de quizzes
        self.quizzes = [
            Quiz(
                id: "quiz_1",
                pergunta: "O que é uma variável em Swift?",
                respostas: [
                    Resposta(texto: "Um espaço na memória que armazena um valor mutável", correta: true),
                    Resposta(texto: "Um valor que não pode ser alterado", correta: false),
                    Resposta(texto: "Um tipo de dados específico", correta: false),
                    Resposta(texto: "Uma constante do sistema", correta: false)
                ]
            ),
            Quiz(
                id: "quiz_2",
                pergunta: "Qual é a diferença entre var e let?",
                respostas: [
                    Resposta(texto: "var é mutável, let é imutável", correta: true),
                    Resposta(texto: "Não há diferença", correta: false),
                    Resposta(texto: "let é mutável, var é imutável", correta: false),
                    Resposta(texto: "Apenas var pode ser usada", correta: false)
                ]
            ),
            Quiz(
                id: "quiz_3",
                pergunta: "Qual tipo é usado para números decimais?",
                respostas: [
                    Resposta(texto: "Double", correta: true),
                    Resposta(texto: "Int", correta: false),
                    Resposta(texto: "String", correta: false),
                    Resposta(texto: "Bool", correta: false)
                ]
            ),
            Quiz(
                id: "quiz_4",
                pergunta: "O índice do primeiro elemento de um array é?",
                respostas: [
                    Resposta(texto: "0", correta: true),
                    Resposta(texto: "1", correta: false),
                    Resposta(texto: "-1", correta: false),
                    Resposta(texto: "Depende do array", correta: false)
                ]
            ),
            Quiz(
                id: "quiz_5",
                pergunta: "Como você acessa um valor em um dicionário?",
                respostas: [
                    Resposta(texto: "Usando a chave entre colchetes", correta: true),
                    Resposta(texto: "Usando um índice", correta: false),
                    Resposta(texto: "Usando um método get()", correta: false),
                    Resposta(texto: "Acessando diretamente", correta: false)
                ]
            ),
            Quiz(
                id: "quiz_6",
                pergunta: "O que significa o símbolo ? após um tipo?",
                respostas: [
                    Resposta(texto: "Que o valor pode ser nil", correta: true),
                    Resposta(texto: "Que é uma pergunta", correta: false),
                    Resposta(texto: "Que é obrigatório", correta: false),
                    Resposta(texto: "Que é um comentário", correta: false)
                ]
            ),
            Quiz(
                id: "quiz_7",
                pergunta: "Qual é a forma segura de unwrap um Optional?",
                respostas: [
                    Resposta(texto: "if let", correta: true),
                    Resposta(texto: "force (!) apenas", correta: false),
                    Resposta(texto: "Não há forma segura", correta: false),
                    Resposta(texto: "var apenas", correta: false)
                ]
            ),
            Quiz(
                id: "quiz_8",
                pergunta: "Struct é um tipo valor ou referência?",
                respostas: [
                    Resposta(texto: "Tipo valor", correta: true),
                    Resposta(texto: "Tipo referência", correta: false),
                    Resposta(texto: "Ambos", correta: false),
                    Resposta(texto: "Nenhum dos dois", correta: false)
                ]
            ),
            Quiz(
                id: "quiz_9",
                pergunta: "Class é um tipo valor ou referência?",
                respostas: [
                    Resposta(texto: "Tipo referência", correta: true),
                    Resposta(texto: "Tipo valor", correta: false),
                    Resposta(texto: "Ambos", correta: false),
                    Resposta(texto: "Nenhum dos dois", correta: false)
                ]
            ),
            Quiz(
                id: "quiz_10",
                pergunta: "O que é uma enumeração (enum)?",
                respostas: [
                    Resposta(texto: "Um conjunto de casos possíveis", correta: true),
                    Resposta(texto: "Uma função", correta: false),
                    Resposta(texto: "Uma classe", correta: false),
                    Resposta(texto: "Uma variável", correta: false)
                ]
            ),
            Quiz(
                id: "quiz_11",
                pergunta: "O que é um protocol em Swift?",
                respostas: [
                    Resposta(texto: "Um contrato que define propriedades e métodos", correta: true),
                    Resposta(texto: "Uma classe", correta: false),
                    Resposta(texto: "Uma variável", correta: false),
                    Resposta(texto: "Uma função", correta: false)
                ]
            ),
            Quiz(
                id: "quiz_12",
                pergunta: "O que é um closure?",
                respostas: [
                    Resposta(texto: "Uma função sem nome", correta: true),
                    Resposta(texto: "Uma classe", correta: false),
                    Resposta(texto: "Uma variável", correta: false),
                    Resposta(texto: "Um tipo de loop", correta: false)
                ]
            ),
            Quiz(
                id: "quiz_13",
                pergunta: "O que permite Codable?",
                respostas: [
                    Resposta(texto: "Converter JSON para Swift e vice-versa", correta: true),
                    Resposta(texto: "Apenas criar variáveis", correta: false),
                    Resposta(texto: "Apenas classes", correta: false),
                    Resposta(texto: "Nada especial", correta: false)
                ]
            ),
            Quiz(
                id: "quiz_14",
                pergunta: "Qual classe faz requisições HTTP em Swift?",
                respostas: [
                    Resposta(texto: "URLSession", correta: true),
                    Resposta(texto: "HTTPRequest", correta: false),
                    Resposta(texto: "Network", correta: false),
                    Resposta(texto: "Request", correta: false)
                ]
            ),
            Quiz(
                id: "quiz_15",
                pergunta: "O que significa MVVM?",
                respostas: [
                    Resposta(texto: "Model View ViewModel", correta: true),
                    Resposta(texto: "Model View Variable Module", correta: false),
                    Resposta(texto: "Multiple Value View Model", correta: false),
                    Resposta(texto: "Main View Virtual Model", correta: false)
                ]
            ),
            Quiz(
                id: "quiz_16",
                pergunta: "O que é UITableView?",
                respostas: [
                    Resposta(texto: "Um componente que exibe lista de dados", correta: true),
                    Resposta(texto: "Um botão", correta: false),
                    Resposta(texto: "Uma tela", correta: false),
                    Resposta(texto: "Um label", correta: false)
                ]
            )
        ]

        // Embaralha as perguntas
        self.quizzes.shuffle()
    }

    /// Retorna o quiz atual
    func quizAtualExemplo() -> Quiz? {
        guard quizAtual >= 0 && quizAtual < quizzes.count else { return nil }
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

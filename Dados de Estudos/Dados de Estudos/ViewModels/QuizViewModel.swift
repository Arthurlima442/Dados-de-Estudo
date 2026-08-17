import Foundation

// MARK: - PerguntaErrada
// Rastreia perguntas erradas para exibir no resultado final
struct PerguntaErrada {
    let pergunta: String
    let respostaClicada: String
    let respostaCorreta: String
}

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

    // Armazena as perguntas erradas para exibir no final
    var perguntasErradas: [PerguntaErrada] = []

    init(dataService: DataServiceProtocol = DataService()) {
        self.dataService = dataService
    }

    /// Carrega os quizzes (com dados mockados de 5 listas diferentes)
    func carregarQuizzes() {
        // Seleciona uma lista aleatória entre 5 listas disponíveis
        let listaIndex = Int.random(in: 0..<5)

        switch listaIndex {
        case 0:
            carregarLista1()
        case 1:
            carregarLista2()
        case 2:
            carregarLista3()
        case 3:
            carregarLista4()
        default:
            carregarLista5()
        }

        // Embaralha as perguntas
        self.quizzes.shuffle()
    }

    /// Lista 1 de quizzes (perguntas originais)
    private func carregarLista1() {
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
    }

    /// Lista 2 de quizzes (novas perguntas)
    private func carregarLista2() {
        self.quizzes = [
            Quiz(id: "quiz_17", pergunta: "Qual é o tipo padrão para String em Swift?", respostas: [
                Resposta(texto: "String", correta: true),
                Resposta(texto: "NSString", correta: false),
                Resposta(texto: "Char", correta: false),
                Resposta(texto: "Text", correta: false)
            ]),
            Quiz(id: "quiz_18", pergunta: "Como você itera sobre um array?", respostas: [
                Resposta(texto: "Usando for-in", correta: true),
                Resposta(texto: "Usando while", correta: false),
                Resposta(texto: "Usando repeat", correta: false),
                Resposta(texto: "Não é possível", correta: false)
            ]),
            Quiz(id: "quiz_19", pergunta: "O que é um guard statement?", respostas: [
                Resposta(texto: "Uma forma segura de unwrap optionals", correta: true),
                Resposta(texto: "Uma função de proteção", correta: false),
                Resposta(texto: "Um tipo de loop", correta: false),
                Resposta(texto: "Um comentário", correta: false)
            ]),
            Quiz(id: "quiz_20", pergunta: "Qual é a extensão padrão de arquivo Swift?", respostas: [
                Resposta(texto: ".swift", correta: true),
                Resposta(texto: ".sw", correta: false),
                Resposta(texto: ".swft", correta: false),
                Resposta(texto: ".s", correta: false)
            ]),
            Quiz(id: "quiz_21", pergunta: "O que é extension em Swift?", respostas: [
                Resposta(texto: "Adiciona funcionalidade a tipos existentes", correta: true),
                Resposta(texto: "Um tipo de variável", correta: false),
                Resposta(texto: "Um tipo de constante", correta: false),
                Resposta(texto: "Um operador", correta: false)
            ]),
            Quiz(id: "quiz_22", pergunta: "Como você declara uma função em Swift?", respostas: [
                Resposta(texto: "func nomeFuncao() { }", correta: true),
                Resposta(texto: "function nomeFuncao() { }", correta: false),
                Resposta(texto: "def nomeFuncao() { }", correta: false),
                Resposta(texto: "fn nomeFuncao() { }", correta: false)
            ]),
            Quiz(id: "quiz_23", pergunta: "O que é Type Aliasing?", respostas: [
                Resposta(texto: "Dar um nome alternativo a um tipo", correta: true),
                Resposta(texto: "Deletar um tipo", correta: false),
                Resposta(texto: "Copiar um tipo", correta: false),
                Resposta(texto: "Modificar um tipo", correta: false)
            ]),
            Quiz(id: "quiz_24", pergunta: "Qual é o operador de coalescência nula?", respostas: [
                Resposta(texto: "??", correta: true),
                Resposta(texto: "??!", correta: false),
                Resposta(texto: "?!", correta: false),
                Resposta(texto: "!?", correta: false)
            ]),
            Quiz(id: "quiz_25", pergunta: "O que é Self em Swift?", respostas: [
                Resposta(texto: "Referência ao tipo atual", correta: true),
                Resposta(texto: "Uma variável global", correta: false),
                Resposta(texto: "Um tipo de dado", correta: false),
                Resposta(texto: "Uma função", correta: false)
            ]),
            Quiz(id: "quiz_26", pergunta: "Como você evita memory leaks em closures?", respostas: [
                Resposta(texto: "Usando [weak self]", correta: true),
                Resposta(texto: "Usando [strong self]", correta: false),
                Resposta(texto: "Não é possível", correta: false),
                Resposta(texto: "Usando try-catch", correta: false)
            ]),
            Quiz(id: "quiz_27", pergunta: "O que é defer?", respostas: [
                Resposta(texto: "Código que executa antes de sair de um escopo", correta: true),
                Resposta(texto: "Um tipo de variável", correta: false),
                Resposta(texto: "Um tipo de função", correta: false),
                Resposta(texto: "Um comentário", correta: false)
            ]),
            Quiz(id: "quiz_28", pergunta: "Como você cria uma instância de uma struct?", respostas: [
                Resposta(texto: "let instancia = NomeStruct()", correta: true),
                Resposta(texto: "new NomeStruct()", correta: false),
                Resposta(texto: "NomeStruct.init()", correta: false),
                Resposta(texto: "Não é possível", correta: false)
            ]),
            Quiz(id: "quiz_29", pergunta: "O que é mutating em Swift?", respostas: [
                Resposta(texto: "Modifica a instância de um tipo valor", correta: true),
                Resposta(texto: "Modifica apenas referências", correta: false),
                Resposta(texto: "Deleta dados", correta: false),
                Resposta(texto: "Cria cópia", correta: false)
            ]),
            Quiz(id: "quiz_30", pergunta: "Qual é o modificador de acesso mais restritivo?", respostas: [
                Resposta(texto: "private", correta: true),
                Resposta(texto: "internal", correta: false),
                Resposta(texto: "public", correta: false),
                Resposta(texto: "open", correta: false)
            ]),
            Quiz(id: "quiz_31", pergunta: "O que é KVO (Key-Value Observing)?", respostas: [
                Resposta(texto: "Observar mudanças em propriedades", correta: true),
                Resposta(texto: "Um tipo de variável", correta: false),
                Resposta(texto: "Uma função", correta: false),
                Resposta(texto: "Um operador", correta: false)
            ]),
            Quiz(id: "quiz_32", pergunta: "Como você converge duas arrays em uma?", respostas: [
                Resposta(texto: "Usando +", correta: true),
                Resposta(texto: "Usando &", correta: false),
                Resposta(texto: "Usando |", correta: false),
                Resposta(texto: "Não é possível", correta: false)
            ])
        ]
    }

    /// Lista 3 de quizzes (novas perguntas)
    private func carregarLista3() {
        self.quizzes = [
            Quiz(id: "quiz_33", pergunta: "O que é um subscript em Swift?", respostas: [
                Resposta(texto: "Permite acessar elementos usando colchetes", correta: true),
                Resposta(texto: "Um tipo de função", correta: false),
                Resposta(texto: "Uma constante", correta: false),
                Resposta(texto: "Um comentário", correta: false)
            ]),
            Quiz(id: "quiz_34", pergunta: "Como você define propriedades computadas?", respostas: [
                Resposta(texto: "Usando get e set", correta: true),
                Resposta(texto: "Usando func", correta: false),
                Resposta(texto: "Usando var apenas", correta: false),
                Resposta(texto: "Não é possível", correta: false)
            ]),
            Quiz(id: "quiz_35", pergunta: "O que é AnyObject em Swift?", respostas: [
                Resposta(texto: "Tipo base para todas as classes", correta: true),
                Resposta(texto: "Um tipo de variável", correta: false),
                Resposta(texto: "Um tipo de função", correta: false),
                Resposta(texto: "Um operador", correta: false)
            ]),
            Quiz(id: "quiz_36", pergunta: "Como você cria um dicionário em Swift?", respostas: [
                Resposta(texto: "var dict: [String: Int] = [:]", correta: true),
                Resposta(texto: "var dict = {}", correta: false),
                Resposta(texto: "var dict = Map()", correta: false),
                Resposta(texto: "var dict = Dictionary", correta: false)
            ]),
            Quiz(id: "quiz_37", pergunta: "O que é herança em OOP?", respostas: [
                Resposta(texto: "Classe filha herda propriedades da classe pai", correta: true),
                Resposta(texto: "Copiar código", correta: false),
                Resposta(texto: "Uma variável", correta: false),
                Resposta(texto: "Um função", correta: false)
            ]),
            Quiz(id: "quiz_38", pergunta: "Como você substitui um método de uma classe pai?", respostas: [
                Resposta(texto: "Usando override", correta: true),
                Resposta(texto: "Usando override func", correta: false),
                Resposta(texto: "Não é possível", correta: false),
                Resposta(texto: "Usando new", correta: false)
            ]),
            Quiz(id: "quiz_39", pergunta: "O que é failable initializer?", respostas: [
                Resposta(texto: "Inicializador que pode retornar nil", correta: true),
                Resposta(texto: "Inicializador que falha", correta: false),
                Resposta(texto: "Um tipo de variável", correta: false),
                Resposta(texto: "Um tipo de função", correta: false)
            ]),
            Quiz(id: "quiz_40", pergunta: "Como você cria um enum com valores associados?", respostas: [
                Resposta(texto: "case exemplo(String)", correta: true),
                Resposta(texto: "case exemplo: String", correta: false),
                Resposta(texto: "case exemplo = String", correta: false),
                Resposta(texto: "Não é possível", correta: false)
            ]),
            Quiz(id: "quiz_41", pergunta: "O que é raw value em enum?", respostas: [
                Resposta(texto: "Um valor padrão para cada caso", correta: true),
                Resposta(texto: "Um tipo de variável", correta: false),
                Resposta(texto: "Uma função", correta: false),
                Resposta(texto: "Um operador", correta: false)
            ]),
            Quiz(id: "quiz_42", pergunta: "Como você implementa um protocol?", respostas: [
                Resposta(texto: "Usando extension ou class que adere ao protocol", correta: true),
                Resposta(texto: "Usando herança", correta: false),
                Resposta(texto: "Usando imports", correta: false),
                Resposta(texto: "Não é possível", correta: false)
            ]),
            Quiz(id: "quiz_43", pergunta: "O que são associated types em protocols?", respostas: [
                Resposta(texto: "Placeholders para tipos que serão definidos depois", correta: true),
                Resposta(texto: "Um tipo de variável", correta: false),
                Resposta(texto: "Um tipo de função", correta: false),
                Resposta(texto: "Um operador", correta: false)
            ]),
            Quiz(id: "quiz_44", pergunta: "Como você captura valores em closures?", respostas: [
                Resposta(texto: "Automaticamente pelo escopo", correta: true),
                Resposta(texto: "Sempre explicitamente", correta: false),
                Resposta(texto: "Nunca captura", correta: false),
                Resposta(texto: "Usando @capture", correta: false)
            ]),
            Quiz(id: "quiz_45", pergunta: "O que é escaping closure?", respostas: [
                Resposta(texto: "Closure que é chamada fora do escopo da função", correta: true),
                Resposta(texto: "Um closure dentro de outro", correta: false),
                Resposta(texto: "Um closure que falha", correta: false),
                Resposta(texto: "Um tipo de variável", correta: false)
            ]),
            Quiz(id: "quiz_46", pergunta: "Como você decodifica JSON com Codable?", respostas: [
                Resposta(texto: "Usando JSONDecoder().decode()", correta: true),
                Resposta(texto: "Usando JSON.parse()", correta: false),
                Resposta(texto: "Usando JSONDeserializer", correta: false),
                Resposta(texto: "Não é possível", correta: false)
            ]),
            Quiz(id: "quiz_47", pergunta: "Como você codifica para JSON com Codable?", respostas: [
                Resposta(texto: "Usando JSONEncoder().encode()", correta: true),
                Resposta(texto: "Usando JSON.stringify()", correta: false),
                Resposta(texto: "Usando JSONSerializer", correta: false),
                Resposta(texto: "Não é possível", correta: false)
            ]),
            Quiz(id: "quiz_48", pergunta: "O que é CodingKey em Codable?", respostas: [
                Resposta(texto: "Mapeia propriedades para chaves JSON diferentes", correta: true),
                Resposta(texto: "Uma chave de segurança", correta: false),
                Resposta(texto: "Um tipo de variável", correta: false),
                Resposta(texto: "Uma função", correta: false)
            ])
        ]
    }

    /// Lista 4 de quizzes (novas perguntas)
    private func carregarLista4() {
        self.quizzes = [
            Quiz(id: "quiz_49", pergunta: "Como você inicia uma requisição HTTP com URLSession?", respostas: [
                Resposta(texto: "URLSession.shared.dataTask()", correta: true),
                Resposta(texto: "URLSession().get()", correta: false),
                Resposta(texto: "URLRequest.load()", correta: false),
                Resposta(texto: "HTTP.request()", correta: false)
            ]),
            Quiz(id: "quiz_50", pergunta: "O que é URLRequest em Swift?", respostas: [
                Resposta(texto: "Um objeto que representa uma requisição HTTP", correta: true),
                Resposta(texto: "Uma resposta de servidor", correta: false),
                Resposta(texto: "Uma URL", correta: false),
                Resposta(texto: "Um tipo de conexão", correta: false)
            ]),
            Quiz(id: "quiz_51", pergunta: "Como você trata erros em URLSession?", respostas: [
                Resposta(texto: "Verificando se error != nil no completion handler", correta: true),
                Resposta(texto: "Usando try-catch", correta: false),
                Resposta(texto: "Usando do-catch", correta: false),
                Resposta(texto: "Não é possível", correta: false)
            ]),
            Quiz(id: "quiz_52", pergunta: "O que é HTTP status code 200?", respostas: [
                Resposta(texto: "Sucesso", correta: true),
                Resposta(texto: "Erro de servidor", correta: false),
                Resposta(texto: "Não encontrado", correta: false),
                Resposta(texto: "Acesso negado", correta: false)
            ]),
            Quiz(id: "quiz_53", pergunta: "O que é HTTP status code 404?", respostas: [
                Resposta(texto: "Recurso não encontrado", correta: true),
                Resposta(texto: "Erro de servidor", correta: false),
                Resposta(texto: "Sucesso", correta: false),
                Resposta(texto: "Acesso negado", correta: false)
            ]),
            Quiz(id: "quiz_54", pergunta: "Como você define o método HTTP em URLRequest?", respostas: [
                Resposta(texto: "urlRequest.httpMethod = \"GET\"", correta: true),
                Resposta(texto: "urlRequest.method = \"GET\"", correta: false),
                Resposta(texto: "urlRequest.request = \"GET\"", correta: false),
                Resposta(texto: "urlRequest.type = \"GET\"", correta: false)
            ]),
            Quiz(id: "quiz_55", pergunta: "O que é MVVM?", respostas: [
                Resposta(texto: "Model, View, ViewModel", correta: true),
                Resposta(texto: "Model, Variable, View, Module", correta: false),
                Resposta(texto: "Module, View, Value, Model", correta: false),
                Resposta(texto: "Main, Virtual, View, Module", correta: false)
            ]),
            Quiz(id: "quiz_56", pergunta: "Qual é a responsabilidade do ViewModel em MVVM?", respostas: [
                Resposta(texto: "Gerenciar lógica de apresentação e preparar dados", correta: true),
                Resposta(texto: "Desenhar a interface", correta: false),
                Resposta(texto: "Conectar ao servidor", correta: false),
                Resposta(texto: "Gerenciar banco de dados", correta: false)
            ]),
            Quiz(id: "quiz_57", pergunta: "Qual é a responsabilidade do Model em MVVM?", respostas: [
                Resposta(texto: "Representar dados e lógica de negócio", correta: true),
                Resposta(texto: "Desenhar a interface", correta: false),
                Resposta(texto: "Gerenciar requisições HTTP", correta: false),
                Resposta(texto: "Processar eventos de toque", correta: false)
            ]),
            Quiz(id: "quiz_58", pergunta: "Como você passa dados do ViewController para o ViewModel?", respostas: [
                Resposta(texto: "Através do inicializador ou métodos", correta: true),
                Resposta(texto: "Através de NotificationCenter", correta: false),
                Resposta(texto: "Através de UserDefaults", correta: false),
                Resposta(texto: "Não é possível", correta: false)
            ]),
            Quiz(id: "quiz_59", pergunta: "O que é UIViewController em UIKit?", respostas: [
                Resposta(texto: "Gerencia uma tela e interações do usuário", correta: true),
                Resposta(texto: "Um botão", correta: false),
                Resposta(texto: "Um label", correta: false),
                Resposta(texto: "Um tipo de dados", correta: false)
            ]),
            Quiz(id: "quiz_60", pergunta: "Como você adiciona uma subview a uma view?", respostas: [
                Resposta(texto: "Usando addSubview()", correta: true),
                Resposta(texto: "Usando add()", correta: false),
                Resposta(texto: "Usando appendChild()", correta: false),
                Resposta(texto: "Usando insert()", correta: false)
            ]),
            Quiz(id: "quiz_61", pergunta: "O que é Auto Layout?", respostas: [
                Resposta(texto: "Sistema de posicionamento de views com constraints", correta: true),
                Resposta(texto: "Um tipo de animação", correta: false),
                Resposta(texto: "Uma função", correta: false),
                Resposta(texto: "Um tipo de dado", correta: false)
            ]),
            Quiz(id: "quiz_62", pergunta: "Como você cria uma constraint em código?", respostas: [
                Resposta(texto: "NSLayoutConstraint.activate([constraint])", correta: true),
                Resposta(texto: "constraint.add()", correta: false),
                Resposta(texto: "view.addConstraint()", correta: false),
                Resposta(texto: "Não é possível", correta: false)
            ]),
            Quiz(id: "quiz_63", pergunta: "O que é navigationController em UIKit?", respostas: [
                Resposta(texto: "Gerencia uma pilha de view controllers", correta: true),
                Resposta(texto: "Um botão de navegação", correta: false),
                Resposta(texto: "Uma view", correta: false),
                Resposta(texto: "Um tipo de dados", correta: false)
            ]),
            Quiz(id: "quiz_64", pergunta: "Como você navega para outro view controller?", respostas: [
                Resposta(texto: "Usando navigationController?.pushViewController()", correta: true),
                Resposta(texto: "Usando segue", correta: false),
                Resposta(texto: "Usando present()", correta: false),
                Resposta(texto: "Não é possível", correta: false)
            ])
        ]
    }

    /// Lista 5 de quizzes (novas perguntas)
    private func carregarLista5() {
        self.quizzes = [
            Quiz(id: "quiz_65", pergunta: "O que é view controller modal?", respostas: [
                Resposta(texto: "Um view controller apresentado sobre outro", correta: true),
                Resposta(texto: "Um view controller com animação", correta: false),
                Resposta(texto: "Um view controller em navegação", correta: false),
                Resposta(texto: "Um tipo de dado", correta: false)
            ]),
            Quiz(id: "quiz_66", pergunta: "Como você apresenta um view controller modalmente?", respostas: [
                Resposta(texto: "Usando present()", correta: true),
                Resposta(texto: "Usando push()", correta: false),
                Resposta(texto: "Usando show()", correta: false),
                Resposta(texto: "Não é possível", correta: false)
            ]),
            Quiz(id: "quiz_67", pergunta: "O que é UIButton em UIKit?", respostas: [
                Resposta(texto: "Um componente que responde a toques", correta: true),
                Resposta(texto: "Um label", correta: false),
                Resposta(texto: "Uma view", correta: false),
                Resposta(texto: "Um tipo de dados", correta: false)
            ]),
            Quiz(id: "quiz_68", pergunta: "Como você adiciona uma ação a um botão?", respostas: [
                Resposta(texto: "Usando addTarget()", correta: true),
                Resposta(texto: "Usando setAction()", correta: false),
                Resposta(texto: "Usando onTap()", correta: false),
                Resposta(texto: "Não é possível", correta: false)
            ]),
            Quiz(id: "quiz_69", pergunta: "O que é UILabel em UIKit?", respostas: [
                Resposta(texto: "Um componente que exibe texto", correta: true),
                Resposta(texto: "Um botão", correta: false),
                Resposta(texto: "Um campo de entrada", correta: false),
                Resposta(texto: "Um tipo de dados", correta: false)
            ]),
            Quiz(id: "quiz_70", pergunta: "Como você define o texto de um label?", respostas: [
                Resposta(texto: "label.text = \"Texto\"", correta: true),
                Resposta(texto: "label.setText(\"Texto\")", correta: false),
                Resposta(texto: "label.value = \"Texto\"", correta: false),
                Resposta(texto: "label.content = \"Texto\"", correta: false)
            ]),
            Quiz(id: "quiz_71", pergunta: "O que é UITextField em UIKit?", respostas: [
                Resposta(texto: "Um campo de entrada de texto", correta: true),
                Resposta(texto: "Um label", correta: false),
                Resposta(texto: "Um botão", correta: false),
                Resposta(texto: "Um tipo de dados", correta: false)
            ]),
            Quiz(id: "quiz_72", pergunta: "Como você obtém o texto de um UITextField?", respostas: [
                Resposta(texto: "textField.text", correta: true),
                Resposta(texto: "textField.value", correta: false),
                Resposta(texto: "textField.getString()", correta: false),
                Resposta(texto: "textField.content", correta: false)
            ]),
            Quiz(id: "quiz_73", pergunta: "O que é UIScrollView em UIKit?", respostas: [
                Resposta(texto: "Um componente que permite scrolling", correta: true),
                Resposta(texto: "Um botão", correta: false),
                Resposta(texto: "Um label", correta: false),
                Resposta(texto: "Um tipo de dados", correta: false)
            ]),
            Quiz(id: "quiz_74", pergunta: "O que é contentSize em UIScrollView?", respostas: [
                Resposta(texto: "Tamanho do conteúdo dentro do scroll", correta: true),
                Resposta(texto: "Tamanho da view visível", correta: false),
                Resposta(texto: "Número de itens", correta: false),
                Resposta(texto: "Um tipo de dados", correta: false)
            ]),
            Quiz(id: "quiz_75", pergunta: "O que é UIImageView em UIKit?", respostas: [
                Resposta(texto: "Um componente que exibe imagens", correta: true),
                Resposta(texto: "Um label", correta: false),
                Resposta(texto: "Um botão", correta: false),
                Resposta(texto: "Um tipo de dados", correta: false)
            ]),
            Quiz(id: "quiz_76", pergunta: "Como você define uma imagem em UIImageView?", respostas: [
                Resposta(texto: "imageView.image = UIImage(named: \"imagem\")", correta: true),
                Resposta(texto: "imageView.setImage(\"imagem\")", correta: false),
                Resposta(texto: "imageView.src = \"imagem\"", correta: false),
                Resposta(texto: "imageView.picture = \"imagem\"", correta: false)
            ]),
            Quiz(id: "quiz_77", pergunta: "O que é viewDidLoad() em UIViewController?", respostas: [
                Resposta(texto: "Método chamado quando a view foi carregada", correta: true),
                Resposta(texto: "Método chamado quando a view aparece", correta: false),
                Resposta(texto: "Método chamado quando a view desaparece", correta: false),
                Resposta(texto: "Um tipo de variável", correta: false)
            ]),
            Quiz(id: "quiz_78", pergunta: "O que é viewWillAppear() em UIViewController?", respostas: [
                Resposta(texto: "Método chamado antes da view aparecer", correta: true),
                Resposta(texto: "Método chamado depois da view aparecer", correta: false),
                Resposta(texto: "Método chamado quando a view é carregada", correta: false),
                Resposta(texto: "Método chamado quando a view desaparece", correta: false)
            ]),
            Quiz(id: "quiz_79", pergunta: "Como você recarrega dados de uma tableview?", respostas: [
                Resposta(texto: "tableView.reloadData()", correta: true),
                Resposta(texto: "tableView.reload()", correta: false),
                Resposta(texto: "tableView.refresh()", correta: false),
                Resposta(texto: "tableView.update()", correta: false)
            ]),
            Quiz(id: "quiz_80", pergunta: "O que é delegate em UIKit?", respostas: [
                Resposta(texto: "Objeto que implementa comportamentos de outro objeto", correta: true),
                Resposta(texto: "Um tipo de função", correta: false),
                Resposta(texto: "Um tipo de variável", correta: false),
                Resposta(texto: "Um tipo de dado", correta: false)
            ])
        ]
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
                    // Armazena a pergunta errada
                    let respostaClicadaTexto = quizAtualItem.respostas[indexResposta].texto
                    let respostaCertaTexto = quizAtualItem.respostas[indexCerto].texto
                    let perguntaErrada = PerguntaErrada(
                        pergunta: quizAtualItem.pergunta,
                        respostaClicada: respostaClicadaTexto,
                        respostaCorreta: respostaCertaTexto
                    )
                    perguntasErradas.append(perguntaErrada)
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

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

    /// Lista 1 de quizzes (perguntas básicas + comportamentais para junior)
    private func carregarLista1() {
        self.quizzes = [
            Quiz(id: "quiz_1", pergunta: "O que é uma variável em Swift?", respostas: [
                Resposta(texto: "Um espaço na memória que armazena um valor mutável", correta: true),
                Resposta(texto: "Um valor que não pode ser alterado", correta: false),
                Resposta(texto: "Um tipo de dados específico", correta: false),
                Resposta(texto: "Uma constante do sistema", correta: false)
            ]),
            Quiz(id: "quiz_2", pergunta: "Qual é a diferença entre var e let?", respostas: [
                Resposta(texto: "var é mutável, let é imutável", correta: true),
                Resposta(texto: "Não há diferença", correta: false),
                Resposta(texto: "let é mutável, var é imutável", correta: false),
                Resposta(texto: "Apenas var pode ser usada", correta: false)
            ]),
            Quiz(id: "quiz_3", pergunta: "Como você evita crashes por Optional?", respostas: [
                Resposta(texto: "Usando if let ou guard let", correta: true),
                Resposta(texto: "Ignorando optionals", correta: false),
                Resposta(texto: "Usando ! sempre", correta: false),
                Resposta(texto: "Não é possível evitar", correta: false)
            ]),
            Quiz(id: "quiz_4", pergunta: "O que são Memory Leaks em iOS?", respostas: [
                Resposta(texto: "Memória alocada mas não liberada", correta: true),
                Resposta(texto: "Variáveis deletadas", correta: false),
                Resposta(texto: "Funções muito longas", correta: false),
                Resposta(texto: "Arrays muito grandes", correta: false)
            ]),
            Quiz(id: "quiz_5", pergunta: "Como você debugaria um crash aleatório?", respostas: [
                Resposta(texto: "Verificar logs, usar Xcode debugger e reproduzir", correta: true),
                Resposta(texto: "Deletar código até funcionar", correta: false),
                Resposta(texto: "Esperar o app parar de crashear sozinho", correta: false),
                Resposta(texto: "Reiniciar o Xcode", correta: false)
            ]),
            Quiz(id: "quiz_6", pergunta: "Qual é o ciclo de vida de um UIViewController?", respostas: [
                Resposta(texto: "init → loadView → viewDidLoad → viewWillAppear → viewDidAppear", correta: true),
                Resposta(texto: "viewDidLoad → viewDidAppear → init", correta: false),
                Resposta(texto: "Não tem ciclo, é linear", correta: false),
                Resposta(texto: "Depende do desenvolvedor", correta: false)
            ]),
            Quiz(id: "quiz_7", pergunta: "O que fazer se recebe uma tarefa que não entende?", respostas: [
                Resposta(texto: "Fazer perguntas ao time e documentar o entendimento", correta: true),
                Resposta(texto: "Começar a codar e descobrir", correta: false),
                Resposta(texto: "Pedir para outra pessoa fazer", correta: false),
                Resposta(texto: "Ignorar e fazer o que acha correto", correta: false)
            ]),
            Quiz(id: "quiz_8", pergunta: "Strong vs Weak references: quando usar weak?", respostas: [
                Resposta(texto: "Em closures para evitar retain cycles", correta: true),
                Resposta(texto: "Sempre, é mais seguro", correta: false),
                Resposta(texto: "Nunca, strong é melhor", correta: false),
                Resposta(texto: "Só em classes grandes", correta: false)
            ]),
            Quiz(id: "quiz_9", pergunta: "Como você resolveria conflito com colega de código?", respostas: [
                Resposta(texto: "Conversar, entender a visão dele e encontrar solução juntos", correta: true),
                Resposta(texto: "Insistir que sua solução é melhor", correta: false),
                Resposta(texto: "Ignorar e fazer seu jeito", correta: false),
                Resposta(texto: "Levar ao gerente", correta: false)
            ]),
            Quiz(id: "quiz_10", pergunta: "Por que usar MVVM em vez de MVC?", respostas: [
                Resposta(texto: "Separação melhor, VC fica mais leve, fácil testar", correta: true),
                Resposta(texto: "Não há diferença real", correta: false),
                Resposta(texto: "MVVM é mais lento", correta: false),
                Resposta(texto: "MVC é melhor para iOS", correta: false)
            ]),
            Quiz(id: "quiz_11", pergunta: "O que é Dependency Injection?", respostas: [
                Resposta(texto: "Passar dependências pelo init em vez de criar dentro", correta: true),
                Resposta(texto: "Uma injeção de código malicioso", correta: false),
                Resposta(texto: "Uma biblioteca do iOS", correta: false),
                Resposta(texto: "Um padrão de design avançado", correta: false)
            ]),
            Quiz(id: "quiz_12", pergunta: "Como você aproveitaria feedback de code review?", respostas: [
                Resposta(texto: "Entender, aprender e aplicar melhorias no código", correta: true),
                Resposta(texto: "Ignorar se discordar", correta: false),
                Resposta(texto: "Deixar para próxima vez", correta: false),
                Resposta(texto: "Ficar na defensiva", correta: false)
            ]),
            Quiz(id: "quiz_13", pergunta: "Auto Layout: qual é o objetivo principal?", respostas: [
                Resposta(texto: "Adaptar layout para diferentes tamanhos de tela", correta: true),
                Resposta(texto: "Fazer interface mais bonita", correta: false),
                Resposta(texto: "Agilizar desenvolvimento", correta: false),
                Resposta(texto: "Substituir Storyboard", correta: false)
            ]),
            Quiz(id: "quiz_14", pergunta: "Como você manteria código limpo e legível?", respostas: [
                Resposta(texto: "Nomes descritivos, funções pequenas, comentários quando necessário", correta: true),
                Resposta(texto: "Muitos comentários explicando tudo", correta: false),
                Resposta(texto: "Sem comentários, código deve falar", correta: false),
                Resposta(texto: "Qualquer forma, contanto que funcione", correta: false)
            ]),
            Quiz(id: "quiz_15", pergunta: "O que é um Protocol em Swift?", respostas: [
                Resposta(texto: "Um contrato definindo interface que tipos devem seguir", correta: true),
                Resposta(texto: "Um tipo de classe", correta: false),
                Resposta(texto: "Uma função especial", correta: false),
                Resposta(texto: "Uma constante global", correta: false)
            ]),
            Quiz(id: "quiz_16", pergunta: "Como você criaria um teste para uma classe?", respostas: [
                Resposta(texto: "Isolar a classe, injetar dependências mock, testar comportamento", correta: true),
                Resposta(texto: "Clicar no app manualmente", correta: false),
                Resposta(texto: "Testar a UI diretamente", correta: false),
                Resposta(texto: "Não é necessário testar", correta: false)
            ])
        ]
        embaralharRespostas()
    }

    /// Lista 2 de quizzes (perguntas intermediárias + comportamentais)
    private func carregarLista2() {
        self.quizzes = [
            Quiz(id: "quiz_17", pergunta: "Como você itera sobre um array?", respostas: [
                Resposta(texto: "Usando for-in", correta: true),
                Resposta(texto: "Usando while", correta: false),
                Resposta(texto: "Usando repeat", correta: false),
                Resposta(texto: "Não é possível", correta: false)
            ]),
            Quiz(id: "quiz_18", pergunta: "O que é um guard statement?", respostas: [
                Resposta(texto: "Uma forma segura de unwrap optionals", correta: true),
                Resposta(texto: "Uma função de proteção", correta: false),
                Resposta(texto: "Um tipo de loop", correta: false),
                Resposta(texto: "Um comentário", correta: false)
            ]),
            Quiz(id: "quiz_19", pergunta: "Como você trataria um erro de requisição HTTP?", respostas: [
                Resposta(texto: "Verificar error, status code e dados recebidos", correta: true),
                Resposta(texto: "Ignorar e assumir sucesso", correta: false),
                Resposta(texto: "Sempre fazer retry", correta: false),
                Resposta(texto: "Mostrar mensagem genérica", correta: false)
            ]),
            Quiz(id: "quiz_20", pergunta: "O que é um guard statement?", respostas: [
                Resposta(texto: "Protege código, saindo cedo se condição falha", correta: true),
                Resposta(texto: "Um tipo de variável", correta: false),
                Resposta(texto: "Uma constante", correta: false),
                Resposta(texto: "Um comentário", correta: false)
            ]),
            Quiz(id: "quiz_21", pergunta: "Como você melhoraria performance de uma tableview?", respostas: [
                Resposta(texto: "Reusabilidade de cells, lazy loading, otimizar imageView", correta: true),
                Resposta(texto: "Aumentar número de cells", correta: false),
                Resposta(texto: "Não há como melhorar", correta: false),
                Resposta(texto: "Usar ScrollView em vez disso", correta: false)
            ]),
            Quiz(id: "quiz_22", pergunta: "O que é um Extension em Swift?", respostas: [
                Resposta(texto: "Adiciona funcionalidade a tipos existentes", correta: true),
                Resposta(texto: "Um tipo de classe", correta: false),
                Resposta(texto: "Uma variável", correta: false),
                Resposta(texto: "Um operador", correta: false)
            ]),
            Quiz(id: "quiz_23", pergunta: "Como você aprende nova tecnologia rapidamente?", respostas: [
                Resposta(texto: "Estudar documentação, fazer pequenos projetos, praticar", correta: true),
                Resposta(texto: "Só assistir vídeos", correta: false),
                Resposta(texto: "Copiar código de tutorials", correta: false),
                Resposta(texto: "Esperar outro ensinar", correta: false)
            ]),
            Quiz(id: "quiz_24", pergunta: "Qual é a diferença entre init? e init!?", respostas: [
                Resposta(texto: "init? retorna nil se falha, init! faz crash", correta: true),
                Resposta(texto: "Não há diferença", correta: false),
                Resposta(texto: "init! é mais seguro", correta: false),
                Resposta(texto: "São o mesmo", correta: false)
            ]),
            Quiz(id: "quiz_25", pergunta: "Como lidar com prazo apertado?", respostas: [
                Resposta(texto: "Priorizar features, comunicar riscos, pedir ajuda", correta: true),
                Resposta(texto: "Ignorar qualidade do código", correta: false),
                Resposta(texto: "Fazer tudo sozinho mais rápido", correta: false),
                Resposta(texto: "Prometer que vai entregar no prazo", correta: false)
            ]),
            Quiz(id: "quiz_26", pergunta: "O que é Closure Capture List?", respostas: [
                Resposta(texto: "Define como o closure captura variáveis ([weak self])", correta: true),
                Resposta(texto: "Uma lista de closures", correta: false),
                Resposta(texto: "Um tipo de array", correta: false),
                Resposta(texto: "Uma função", correta: false)
            ]),
            Quiz(id: "quiz_27", pergunta: "Como você escalaria código para projeto maior?", respostas: [
                Resposta(texto: "Modularizar, usar MVVM, testes, documentação", correta: true),
                Resposta(texto: "Copiar estrutura de projeto pequeno", correta: false),
                Resposta(texto: "Não há diferença", correta: false),
                Resposta(texto: "Usar mais libraries", correta: false)
            ]),
            Quiz(id: "quiz_28", pergunta: "O que é Type Method em Swift?", respostas: [
                Resposta(texto: "Método chamado no tipo, não na instância", correta: true),
                Resposta(texto: "Um tipo de variável", correta: false),
                Resposta(texto: "Uma constante", correta: false),
                Resposta(texto: "Um comentário", correta: false)
            ]),
            Quiz(id: "quiz_29", pergunta: "Como você documentaria código complexo?", respostas: [
                Resposta(texto: "Comentários breves, documentação de função, exemplos", correta: true),
                Resposta(texto: "Sem comentários, código fala", correta: false),
                Resposta(texto: "Muitos comentários explicando tudo", correta: false),
                Resposta(texto: "Documentação separada", correta: false)
            ]),
            Quiz(id: "quiz_30", pergunta: "O que é um Designated Initializer?", respostas: [
                Resposta(texto: "Inicializador principal que inicializa todas as propriedades", correta: true),
                Resposta(texto: "Um inicializador especial", correta: false),
                Resposta(texto: "Uma função", correta: false),
                Resposta(texto: "Uma variável", correta: false)
            ]),
            Quiz(id: "quiz_31", pergunta: "Como você liida com mudança de requisito?", respostas: [
                Resposta(texto: "Entender novo requisito, replanejar, comunicar impacto", correta: true),
                Resposta(texto: "Reclamar e fazer do jeito antigo", correta: false),
                Resposta(texto: "Ignorar e continuar", correta: false),
                Resposta(texto: "Fazer rápido sem pensar", correta: false)
            ]),
            Quiz(id: "quiz_32", pergunta: "O que é Computed Property?", respostas: [
                Resposta(texto: "Propriedade que calcula valor via get/set", correta: true),
                Resposta(texto: "Uma constante", correta: false),
                Resposta(texto: "Uma variável normal", correta: false),
                Resposta(texto: "Uma função", correta: false)
            ])
        ]
        embaralharRespostas()
    }

    /// Lista 3 de quizzes (perguntas sobre padrões + comportamentais)
    private func carregarLista3() {
        self.quizzes = [
            Quiz(id: "quiz_33", pergunta: "O que é um Singleton Pattern?", respostas: [
                Resposta(texto: "Uma classe com apenas uma instância no app", correta: true),
                Resposta(texto: "Uma função especial", correta: false),
                Resposta(texto: "Um tipo de variável", correta: false),
                Resposta(texto: "Uma constante global", correta: false)
            ]),
            Quiz(id: "quiz_34", pergunta: "Como você testaria um método privado?", respostas: [
                Resposta(texto: "Testar através do método público que a chama", correta: true),
                Resposta(texto: "Tornar público só para testes", correta: false),
                Resposta(texto: "Não é necessário", correta: false),
                Resposta(texto: "Ignorar métodos privados", correta: false)
            ]),
            Quiz(id: "quiz_35", pergunta: "Por que separar Model, View e Logic?", respostas: [
                Resposta(texto: "Para reutilização, testabilidade e manutenção", correta: true),
                Resposta(texto: "Não há razão real", correta: false),
                Resposta(texto: "Só para complexidade", correta: false),
                Resposta(texto: "Para confundir", correta: false)
            ]),
            Quiz(id: "quiz_36", pergunta: "Como você trata Concorrência em iOS?", respostas: [
                Resposta(texto: "Usar GCD (DispatchQueue) ou async/await", correta: true),
                Resposta(texto: "Fazer tudo na main thread", correta: false),
                Resposta(texto: "Não é problema", correta: false),
                Resposta(texto: "Usar threads manualmente", correta: false)
            ]),
            Quiz(id: "quiz_37", pergunta: "Como você se prepara para entrevista técnica?", respostas: [
                Resposta(texto: "Estudar conceitos, fazer projetos, revisar erros", correta: true),
                Resposta(texto: "Decorar respostas", correta: false),
                Resposta(texto: "Confiar na sorte", correta: false),
                Resposta(texto: "Não se preparar", correta: false)
            ]),
            Quiz(id: "quiz_38", pergunta: "O que é um Notification Center?", respostas: [
                Resposta(texto: "Sistema para comunicação entre objetos desacoplados", correta: true),
                Resposta(texto: "Um push notification", correta: false),
                Resposta(texto: "Uma variável", correta: false),
                Resposta(texto: "Uma função", correta: false)
            ]),
            Quiz(id: "quiz_39", pergunta: "Quando usar String Interpolation?", respostas: [
                Resposta(texto: "Para concatenar strings de forma legível", correta: true),
                Resposta(texto: "Sempre", correta: false),
                Resposta(texto: "Nunca", correta: false),
                Resposta(texto: "Só em testes", correta: false)
            ]),
            Quiz(id: "quiz_40", pergunta: "Como você liida com muitas notificações de observadores?", respostas: [
                Resposta(texto: "Remover quando VC desaparece, usar weak references", correta: true),
                Resposta(texto: "Deixar todas ativas", correta: false),
                Resposta(texto: "Não há problema", correta: false),
                Resposta(texto: "Usar apenas um observador", correta: false)
            ]),
            Quiz(id: "quiz_41", pergunta: "O que é KVC (Key-Value Coding)?", respostas: [
                Resposta(texto: "Acessar propriedades através de strings", correta: true),
                Resposta(texto: "Uma variável", correta: false),
                Resposta(texto: "Uma função", correta: false),
                Resposta(texto: "Um comentário", correta: false)
            ]),
            Quiz(id: "quiz_42", pergunta: "Como você se manteria atualizado na tecnologia?", respostas: [
                Resposta(texto: "Ler blogs, acompanhar WWDC, praticar novidades", correta: true),
                Resposta(texto: "Esperar outros explicarem", correta: false),
                Resposta(texto: "Ignorar mudanças", correta: false),
                Resposta(texto: "Só no trabalho", correta: false)
            ]),
            Quiz(id: "quiz_43", pergunta: "O que é Lazy Initialization?", respostas: [
                Resposta(texto: "Criar recurso apenas quando for necessário", correta: true),
                Resposta(texto: "Uma variável preguiçosa", correta: false),
                Resposta(texto: "Uma função", correta: false),
                Resposta(texto: "Um operador", correta: false)
            ]),
            Quiz(id: "quiz_44", pergunta: "Como você resolveria problema complexo?", respostas: [
                Resposta(texto: "Dividir em partes pequenas, atacar uma por vez", correta: true),
                Resposta(texto: "Tentar resolver tudo de uma vez", correta: false),
                Resposta(texto: "Desistir fácil", correta: false),
                Resposta(texto: "Pedir resposta pronta", correta: false)
            ]),
            Quiz(id: "quiz_45", pergunta: "O que é App Lifecycle em UIKit?", respostas: [
                Resposta(texto: "Estados que o app passa: Not running, Inactive, Active, Background, Suspended", correta: true),
                Resposta(texto: "Apenas active e inactive", correta: false),
                Resposta(texto: "Não tem ciclo", correta: false),
                Resposta(texto: "Gerenciado automaticamente", correta: false)
            ]),
            Quiz(id: "quiz_46", pergunta: "Como você buscaria ajuda quando travado?", respostas: [
                Resposta(texto: "Pesquisar, pedir ao time, documentar solução", correta: true),
                Resposta(texto: "Ficar frustrado", correta: false),
                Resposta(texto: "Desistir", correta: false),
                Resposta(texto: "Ignorar o problema", correta: false)
            ]),
            Quiz(id: "quiz_47", pergunta: "O que é ViewCode?", respostas: [
                Resposta(texto: "Criar UI programaticamente sem Storyboard", correta: true),
                Resposta(texto: "Um tipo de Storyboard", correta: false),
                Resposta(texto: "Uma função", correta: false),
                Resposta(texto: "Um comentário", correta: false)
            ]),
            Quiz(id: "quiz_48", pergunta: "Como você documentaria uma função complexa?", respostas: [
                Resposta(texto: "Com documentação clara, exemplo de uso, parâmetros", correta: true),
                Resposta(texto: "Sem documentação", correta: false),
                Resposta(texto: "Com muitos comentários", correta: false),
                Resposta(texto: "Não é necessário", correta: false)
            ])
        ]
        embaralharRespostas()
    }

    /// Lista 4 de quizzes (perguntas sobre networking + comportamentais)
    private func carregarLista4() {
        self.quizzes = [
            Quiz(id: "quiz_49", pergunta: "Como você inicia uma requisição HTTP com URLSession?", respostas: [
                Resposta(texto: "URLSession.shared.dataTask()", correta: true),
                Resposta(texto: "URLSession().get()", correta: false),
                Resposta(texto: "URLRequest.load()", correta: false),
                Resposta(texto: "HTTP.request()", correta: false)
            ]),
            Quiz(id: "quiz_50", pergunta: "Como você trata erro de conexão?", respostas: [
                Resposta(texto: "Verificar error e URLResponse, fazer retry se necessário", correta: true),
                Resposta(texto: "Ignorar e tentar novamente", correta: false),
                Resposta(texto: "Mostrar mensagem genérica", correta: false),
                Resposta(texto: "Não há tratamento", correta: false)
            ]),
            Quiz(id: "quiz_51", pergunta: "O que é um timeout em requisições?", respostas: [
                Resposta(texto: "Tempo máximo de espera por resposta", correta: true),
                Resposta(texto: "Um erro de servidor", correta: false),
                Resposta(texto: "Uma falha de conexão", correta: false),
                Resposta(texto: "Um retry automático", correta: false)
            ]),
            Quiz(id: "quiz_52", pergunta: "Como você liida com grande volume de dados?", respostas: [
                Resposta(texto: "Usar streaming, paginação ou background download", correta: true),
                Resposta(texto: "Baixar tudo de uma vez", correta: false),
                Resposta(texto: "Não há solução", correta: false),
                Resposta(texto: "Aumentar timeout", correta: false)
            ]),
            Quiz(id: "quiz_53", pergunta: "Como você se comportaria em erro de produção?", respostas: [
                Resposta(texto: "Calmamente reproduzir, debugar, reportar achados", correta: true),
                Resposta(texto: "Entrar em pânico", correta: false),
                Resposta(texto: "Culpar outro", correta: false),
                Resposta(texto: "Fingir que não viu", correta: false)
            ]),
            Quiz(id: "quiz_54", pergunta: "Como você criptografaria dados sensíveis?", respostas: [
                Resposta(texto: "Usar Keychain para senhas, SSL/TLS para transmissão", correta: true),
                Resposta(texto: "Armazenar em UserDefaults", correta: false),
                Resposta(texto: "Deixar em texto plano", correta: false),
                Resposta(texto: "Não é necessário", correta: false)
            ]),
            Quiz(id: "quiz_55", pergunta: "O que é SSL Pinning?", respostas: [
                Resposta(texto: "Validar certificado específico em requisições HTTPS", correta: true),
                Resposta(texto: "Um tipo de erro", correta: false),
                Resposta(texto: "Uma função de rede", correta: false),
                Resposta(texto: "Um protocolo", correta: false)
            ]),
            Quiz(id: "quiz_56", pergunta: "Como você testaria requisição HTTP?", respostas: [
                Resposta(texto: "Mock URLSession, testar sucesso e erro", correta: true),
                Resposta(texto: "Fazer requisição real no teste", correta: false),
                Resposta(texto: "Não testar rede", correta: false),
                Resposta(texto: "Ignorar testes de rede", correta: false)
            ]),
            Quiz(id: "quiz_57", pergunta: "Como você cachear dados de rede?", respostas: [
                Resposta(texto: "URLCache built-in ou custom cache com expiração", correta: true),
                Resposta(texto: "Não fazer cache", correta: false),
                Resposta(texto: "Salvar tudo em disco", correta: false),
                Resposta(texto: "Cache nunca expira", correta: false)
            ]),
            Quiz(id: "quiz_58", pergunta: "Como você se adapta a mudanças de API?", respostas: [
                Resposta(texto: "Versionamento, testes, comunicar com backend", correta: true),
                Resposta(texto: "Quebrar quando muda", correta: false),
                Resposta(texto: "Ignorar mudanças", correta: false),
                Resposta(texto: "Fazer workaround", correta: false)
            ]),
            Quiz(id: "quiz_59", pergunta: "O que é Queue Priority em DispatchQueue?", respostas: [
                Resposta(texto: "Define importância de tarefa: userInteractive, default, utility", correta: true),
                Resposta(texto: "Um tipo de erro", correta: false),
                Resposta(texto: "Uma variável", correta: false),
                Resposta(texto: "Uma função", correta: false)
            ]),
            Quiz(id: "quiz_60", pergunta: "Como você executaria tarefa em background?", respostas: [
                Resposta(texto: "Usar DispatchQueue.global() ou async/await", correta: true),
                Resposta(texto: "Executar na main thread", correta: false),
                Resposta(texto: "Usar sleep", correta: false),
                Resposta(texto: "Não é possível", correta: false)
            ]),
            Quiz(id: "quiz_61", pergunta: "O que é Race Condition?", respostas: [
                Resposta(texto: "Múltiplas threads acessando recurso simultaneamente", correta: true),
                Resposta(texto: "Um erro de rede", correta: false),
                Resposta(texto: "Uma função", correta: false),
                Resposta(texto: "Uma variável", correta: false)
            ]),
            Quiz(id: "quiz_62", pergunta: "Como você sincronizaria threads em Swift?", respostas: [
                Resposta(texto: "Usar NSLock ou DispatchSemaphore", correta: true),
                Resposta(texto: "Não é necessário", correta: false),
                Resposta(texto: "Usar sleep", correta: false),
                Resposta(texto: "Não há forma", correta: false)
            ]),
            Quiz(id: "quiz_63", pergunta: "Como você mediria performance da app?", respostas: [
                Resposta(texto: "Usar Instruments, Core Animation, memory profiler", correta: true),
                Resposta(texto: "Só por sensação", correta: false),
                Resposta(texto: "Não há forma", correta: false),
                Resposta(texto: "Confiar em testes", correta: false)
            ]),
            Quiz(id: "quiz_64", pergunta: "Como você lidaria com feedback negativo?", respostas: [
                Resposta(texto: "Ouvir, não tomar como pessoal, aprender e melhorar", correta: true),
                Resposta(texto: "Reclamar e ignorar", correta: false),
                Resposta(texto: "Ficar defensivo", correta: false),
                Resposta(texto: "Desistir", correta: false)
            ])
        ]
        embaralharRespostas()
    }

    /// Lista 5 de quizzes (perguntas sobre UI + comportamentais finais)
    private func carregarLista5() {
        self.quizzes = [
            Quiz(id: "quiz_65", pergunta: "Como você criaria uma UI responsiva?", respostas: [
                Resposta(texto: "Usar Auto Layout com Safe Area e Size Classes", correta: true),
                Resposta(texto: "Usar frames fixos", correta: false),
                Resposta(texto: "Não é possível", correta: false),
                Resposta(texto: "Fazer versão para cada tamanho", correta: false)
            ]),
            Quiz(id: "quiz_66", pergunta: "O que é Safe Area?", respostas: [
                Resposta(texto: "Área segura dentro da view para não sobrepor elementos do iOS", correta: true),
                Resposta(texto: "Um tipo de validação", correta: false),
                Resposta(texto: "Uma função de segurança", correta: false),
                Resposta(texto: "Um protocolo", correta: false)
            ]),
            Quiz(id: "quiz_67", pergunta: "Como você trataria diferentes orientações de tela?", respostas: [
                Resposta(texto: "Usar traits, Auto Layout, e observar rotações", correta: true),
                Resposta(texto: "Fazer interface diferente para cada uma", correta: false),
                Resposta(texto: "Não suportar orientação", correta: false),
                Resposta(texto: "Usar valores fixos", correta: false)
            ]),
            Quiz(id: "quiz_68", pergunta: "Como você validaria entrada de usuário?", respostas: [
                Resposta(texto: "Validar tipo, comprimento, regex quando necessário", correta: true),
                Resposta(texto: "Aceitar qualquer entrada", correta: false),
                Resposta(texto: "Não validar", correta: false),
                Resposta(texto: "Validar apenas no servidor", correta: false)
            ]),
            Quiz(id: "quiz_69", pergunta: "Como você implementaria Dark Mode?", respostas: [
                Resposta(texto: "Usar UIColor semantic colors e traço colorScheme", correta: true),
                Resposta(texto: "Cores fixas", correta: false),
                Resposta(texto: "Não suportar", correta: false),
                Resposta(texto: "Um único tema", correta: false)
            ]),
            Quiz(id: "quiz_70", pergunta: "Como você acessibilizaria seu app?", respostas: [
                Resposta(texto: "VoiceOver, contrast adequado, labels descritivos", correta: true),
                Resposta(texto: "Não é necessário", correta: false),
                Resposta(texto: "Só para usuários específicos", correta: false),
                Resposta(texto: "Não é possível", correta: false)
            ]),
            Quiz(id: "quiz_71", pergunta: "Como você mediria satisfação do usuário?", respostas: [
                Resposta(texto: "Reviews, analytics, feedback, crash reports", correta: true),
                Resposta(texto: "Só números de downloads", correta: false),
                Resposta(texto: "Não há como", correta: false),
                Resposta(texto: "Assumir que está bom", correta: false)
            ]),
            Quiz(id: "quiz_72", pergunta: "Como você trataria internacionalização?", respostas: [
                Resposta(texto: "Strings.strings files, NSLocalizedString, locale settings", correta: true),
                Resposta(texto: "Hardcoded em português", correta: false),
                Resposta(texto: "Não é necessário", correta: false),
                Resposta(texto: "Cada idioma é app diferente", correta: false)
            ]),
            Quiz(id: "quiz_73", pergunta: "Como você se comportaria em aprendizado contínuo?", respostas: [
                Resposta(texto: "Dedicar tempo, estudar novos padrões, compartilhar conhecimento", correta: true),
                Resposta(texto: "Esperar que ensinem", correta: false),
                Resposta(texto: "Não aprender mais", correta: false),
                Resposta(texto: "Apenas quando obrigado", correta: false)
            ]),
            Quiz(id: "quiz_74", pergunta: "O que é Accessibility Inspector?", respostas: [
                Resposta(texto: "Ferramenta para testar acessibilidade do app", correta: true),
                Resposta(texto: "Uma função", correta: false),
                Resposta(texto: "Um protocolo", correta: false),
                Resposta(texto: "Uma variável", correta: false)
            ]),
            Quiz(id: "quiz_75", pergunta: "Como você trataria battery consumption?", respostas: [
                Resposta(texto: "Evitar background tasks desnecessárias, usar efficiency", correta: true),
                Resposta(texto: "Não há como controlar", correta: false),
                Resposta(texto: "Não é importância", correta: false),
                Resposta(texto: "Executar tudo em background", correta: false)
            ]),
            Quiz(id: "quiz_76", pergunta: "Como você colaboraria em projeto grande?", respostas: [
                Resposta(texto: "Git, code review, comunicação, dividir tasks", correta: true),
                Resposta(texto: "Fazer tudo sozinho", correta: false),
                Resposta(texto: "Não colaborar", correta: false),
                Resposta(texto: "Código isolado", correta: false)
            ]),
            Quiz(id: "quiz_77", pergunta: "Como você debugaria memory leak?", respostas: [
                Resposta(texto: "Usar Instruments Memory Profiler, Leaks, buscar retain cycles", correta: true),
                Resposta(texto: "Ignorar", correta: false),
                Resposta(texto: "Não há ferramentas", correta: false),
                Resposta(texto: "Reiniciar app", correta: false)
            ]),
            Quiz(id: "quiz_78", pergunta: "Como você manteria interesse no trabalho?", respostas: [
                Resposta(texto: "Buscar desafios, aprender, ajudar time, celebrar sucessos", correta: true),
                Resposta(texto: "Fazer rotina", correta: false),
                Resposta(texto: "Perder motivação", correta: false),
                Resposta(texto: "Apenas trabalhar", correta: false)
            ]),
            Quiz(id: "quiz_79", pergunta: "Como você entregaria produto com qualidade?", respostas: [
                Resposta(texto: "Testes, code review, atenção a detalhe, iteração", correta: true),
                Resposta(texto: "Rápido sem validar", correta: false),
                Resposta(texto: "Deixar para depois", correta: false),
                Resposta(texto: "Qualidade custa", correta: false)
            ]),
            Quiz(id: "quiz_80", pergunta: "Qual é sua visão como desenvolvedor iOS?", respostas: [
                Resposta(texto: "Crescer, ajudar outros, entregar valor, inovar", correta: true),
                Resposta(texto: "Só ganhar dinheiro", correta: false),
                Resposta(texto: "Não tenho visão", correta: false),
                Resposta(texto: "Apenas seguir tarefas", correta: false)
            ])
        ]
        embaralharRespostas()
    }

    /// Embaralha as respostas de cada pergunta mantendo a resposta correta identificável
    private func embaralharRespostas() {
        self.quizzes = self.quizzes.map { quiz in
            let respostasEmbaralhadas = quiz.respostas.shuffled()
            return Quiz(id: quiz.id, pergunta: quiz.pergunta, respostas: respostasEmbaralhadas)
        }
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

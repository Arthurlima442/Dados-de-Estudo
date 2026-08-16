import UIKit

// MARK: - QuizViewController
// Controla a tela de quiz

class QuizViewController: UIViewController {

    private let quizView = QuizView()
    private let viewModel: QuizViewModel

    init(viewModel: QuizViewModel = QuizViewModel()) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    /// Carrega a view customizada
    override func loadView() {
        view = quizView
    }

    /// Configura a tela e carrega os quizzes
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupBotoes()
        carregarQuizzes()
    }

    /// Define o título da tela
    private func setupUI() {
        title = "Quiz"
        navigationController?.navigationBar.prefersLargeTitles = false
    }

    /// Carrega os quizzes e exibe o primeiro
    private func carregarQuizzes() {
        viewModel.carregarQuizzes()

        if viewModel.totalPerguntas() > 0 {
            exibirQuizAtual()
        }
    }

    /// Configura os botões de resposta
    private func setupBotoes() {
        // Botões das respostas
        for (i, button) in quizView.botoesRespostas.enumerated() {
            button.addTarget(self, action: #selector(respostaBotaoPressionado(_:)), for: .touchUpInside)
            button.tag = i
        }

        // Botão próximo
        quizView.botaoProximo.addTarget(self, action: #selector(proximaPerguntatPressionada), for: .touchUpInside)
        quizView.botaoProximo.isHidden = true
    }

    /// Exibe o quiz atual
    private func exibirQuizAtual() {
        if let quiz = viewModel.quizAtualExemplo() {
            quizView.configurar(quiz: quiz, quizAtual: viewModel.quizAtual, total: viewModel.totalPerguntas())
            quizView.limpar()
            quizView.botaoProximo.isHidden = true
        }
    }

    /// Chamado quando uma resposta é clicada
    @objc private func respostaBotaoPressionado(_ sender: UIButton) {
        let indexResposta = sender.tag

        // Verifica a resposta
        viewModel.verificarResposta(indexResposta)

        // Mostra o resultado
        if let indexCerto = viewModel.respostaCerta {
            let acertou = indexResposta == indexCerto
            quizView.mostrarResultado(respostaClicada: indexResposta, respostaCerta: indexCerto, acertou: acertou)

            // Mostra botão próximo
            quizView.botaoProximo.isHidden = false

            if viewModel.chegouAoFinal() {
                quizView.botaoProximo.setTitle("Ver Resultado", for: .normal)
            } else {
                quizView.botaoProximo.setTitle("Próxima", for: .normal)
            }
        }
    }

    /// Chamado quando o botão próximo é pressionado
    @objc private func proximaPerguntatPressionada() {
        if viewModel.chegouAoFinal() {
            // Vai para a tela de resultado
            exibirTelaResultado()
        } else {
            // Próximo quiz
            viewModel.proximoQuiz()
            exibirQuizAtual()
        }
    }

    /// Exibe a tela de resultado final
    private func exibirTelaResultado() {
        let resultadoVC = ResultadoQuizViewController(viewModel: viewModel)
        navigationController?.pushViewController(resultadoVC, animated: true)
    }
}

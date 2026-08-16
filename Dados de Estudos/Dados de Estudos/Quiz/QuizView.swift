import UIKit

// MARK: - QuizView
// Interface visual do quiz

class QuizView: UIView {

    // Progress - mostra qual pergunta estamos
    private let progressLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.textColor = .secondaryLabel
        label.textAlignment = .center
        return label
    }()

    // Pergunta
    private let perguntaLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        label.textColor = .label
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()

    // Botões das respostas
    private(set) var botoesRespostas: [UIButton] = []

    // Label para mostrar resultado
    private let resultadoLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()

    // Botão próximo
    private(set) var botaoProximo: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Próxima", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        button.backgroundColor = .systemBlue
        button.setTitleColor(.white, for: .normal)
        return button
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    /// Configura a interface visual
    private func setupUI() {
        backgroundColor = .systemBackground

        // Adiciona labels
        addSubview(progressLabel)
        addSubview(perguntaLabel)
        addSubview(resultadoLabel)
        addSubview(botaoProximo)

        // Auto Layout
        progressLabel.translatesAutoresizingMaskIntoConstraints = false
        perguntaLabel.translatesAutoresizingMaskIntoConstraints = false
        resultadoLabel.translatesAutoresizingMaskIntoConstraints = false
        botaoProximo.translatesAutoresizingMaskIntoConstraints = false

        // Progress no topo
        NSLayoutConstraint.activate([
            progressLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 16),
            progressLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            progressLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16)
        ])

        // Pergunta abaixo do progress
        NSLayoutConstraint.activate([
            perguntaLabel.topAnchor.constraint(equalTo: progressLabel.bottomAnchor, constant: 32),
            perguntaLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            perguntaLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16)
        ])

        // Resultado abaixo da pergunta (inicialmente oculto)
        NSLayoutConstraint.activate([
            resultadoLabel.topAnchor.constraint(equalTo: perguntaLabel.bottomAnchor, constant: 32),
            resultadoLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            resultadoLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16)
        ])

        // Botão próximo no final
        NSLayoutConstraint.activate([
            botaoProximo.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -16),
            botaoProximo.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            botaoProximo.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            botaoProximo.heightAnchor.constraint(equalToConstant: 50)
        ])

        botaoProximo.layer.cornerRadius = 8

        // Cria 4 botões de respostas
        criarBotoesRespostas()
    }

    /// Cria 4 botões para as respostas
    private func criarBotoesRespostas() {
        for i in 0..<4 {
            let button = UIButton(type: .system)
            button.setTitle("Resposta \(i + 1)", for: .normal)
            button.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .medium)
            button.backgroundColor = .secondarySystemBackground
            button.setTitleColor(.label, for: .normal)
            button.layer.cornerRadius = 8

            addSubview(button)
            button.translatesAutoresizingMaskIntoConstraints = false

            // Posiciona abaixo da pergunta
            let topAnchor = i == 0 ? perguntaLabel.bottomAnchor :
                (i > 0 ? botoesRespostas[i - 1].bottomAnchor : perguntaLabel.bottomAnchor)
            let constant = i == 0 ? CGFloat(32) : CGFloat(12)

            NSLayoutConstraint.activate([
                button.topAnchor.constraint(equalTo: topAnchor, constant: constant),
                button.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
                button.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
                button.heightAnchor.constraint(equalToConstant: 50)
            ])

            botoesRespostas.append(button)
        }
    }

    /// Preenche a view com os dados do quiz
    func configurar(quiz: Quiz, quizAtual: Int, total: Int) {
        // Progress
        progressLabel.text = "Pergunta \(quizAtual + 1) de \(total)"

        // Pergunta
        perguntaLabel.text = quiz.pergunta

        // Respostas
        for (i, resposta) in quiz.respostas.enumerated() {
            botoesRespostas[i].setTitle(resposta.texto, for: .normal)
            botoesRespostas[i].backgroundColor = .secondarySystemBackground
            botoesRespostas[i].isEnabled = true
        }

        // Limpa resultado
        resultadoLabel.text = ""
        resultadoLabel.isHidden = true
    }

    /// Mostra o resultado (verde se correto, vermelho se errado)
    func mostrarResultado(respostaClicada: Int, respostaCerta: Int, acertou: Bool) {
        // Desabilita todos os botões
        for button in botoesRespostas {
            button.isEnabled = false
        }

        // Muda cor do botão clicado
        if acertou {
            botoesRespostas[respostaClicada].backgroundColor = .systemGreen
            resultadoLabel.text = "✓ Correto!"
            resultadoLabel.textColor = .systemGreen
        } else {
            botoesRespostas[respostaClicada].backgroundColor = .systemRed
            botoesRespostas[respostaCerta].backgroundColor = .systemGreen
            resultadoLabel.text = "✗ Incorreto! A resposta correta é acima."
            resultadoLabel.textColor = .systemRed
        }

        resultadoLabel.isHidden = false
    }

    /// Limpa os botões para a próxima pergunta
    func limpar() {
        for button in botoesRespostas {
            button.backgroundColor = .secondarySystemBackground
            button.setTitleColor(.label, for: .normal)
            button.isEnabled = true
        }
        resultadoLabel.text = ""
        resultadoLabel.isHidden = true
    }
}

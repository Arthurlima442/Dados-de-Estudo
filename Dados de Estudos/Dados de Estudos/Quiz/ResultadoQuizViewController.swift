import UIKit

// MARK: - ResultadoQuizViewController
// Exibe o resultado final do quiz

class ResultadoQuizViewController: UIViewController {

    private let viewModel: QuizViewModel

    init(viewModel: QuizViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    /// Configura a tela
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = "Resultado"

        exibirResultado()
    }

    /// Exibe o resultado final
    private func exibirResultado() {
        let acertos = viewModel.acertos
        let erros = viewModel.erros
        let porcentagem = viewModel.calcularPorcentagem()
        let passou = viewModel.passou()

        // ScrollView para conteúdo
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scrollView)

        // Container dentro do scroll
        let containerView = UIView()
        containerView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(containerView)

        // Constraints do scrollView
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -70)
        ])

        // Constraints do container
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            containerView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            containerView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            containerView.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
        ])

        // Título do resultado
        let tituloLabel = UILabel()
        tituloLabel.font = UIFont.systemFont(ofSize: 28, weight: .bold)
        tituloLabel.textColor = passou ? .systemGreen : .systemRed
        tituloLabel.textAlignment = .center
        tituloLabel.text = passou ? "Parabéns! 🎉" : "Você pode melhorar 💪"
        tituloLabel.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(tituloLabel)

        NSLayoutConstraint.activate([
            tituloLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 24),
            tituloLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
            tituloLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16)
        ])

        // Porcentagem grande
        let porcentagemLabel = UILabel()
        porcentagemLabel.font = UIFont.systemFont(ofSize: 60, weight: .bold)
        porcentagemLabel.textColor = passou ? .systemGreen : .systemOrange
        porcentagemLabel.textAlignment = .center
        porcentagemLabel.text = "\(porcentagem)%"
        porcentagemLabel.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(porcentagemLabel)

        NSLayoutConstraint.activate([
            porcentagemLabel.topAnchor.constraint(equalTo: tituloLabel.bottomAnchor, constant: 24),
            porcentagemLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
            porcentagemLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16)
        ])

        // Estatísticas
        let statsLabel = UILabel()
        statsLabel.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        statsLabel.textColor = .label
        statsLabel.textAlignment = .center
        statsLabel.numberOfLines = 0
        statsLabel.text = "Acertos: \(acertos) ✓\nErros: \(erros) ✗\nTotal: \(acertos + erros)"
        statsLabel.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(statsLabel)

        NSLayoutConstraint.activate([
            statsLabel.topAnchor.constraint(equalTo: porcentagemLabel.bottomAnchor, constant: 32),
            statsLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
            statsLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16)
        ])

        // Mensagem de 80%
        let messagemLabel = UILabel()
        messagemLabel.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        messagemLabel.textColor = .secondaryLabel
        messagemLabel.textAlignment = .center
        messagemLabel.numberOfLines = 0
        messagemLabel.text = passou ? "Nota mínima atingida (80%)" : "Estude mais e tente novamente"
        messagemLabel.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(messagemLabel)

        NSLayoutConstraint.activate([
            messagemLabel.topAnchor.constraint(equalTo: statsLabel.bottomAnchor, constant: 32),
            messagemLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
            messagemLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16)
        ])

        // Se tiver erros, mostra as perguntas erradas
        var ultimoView: UIView = messagemLabel
        if !viewModel.perguntasErradas.isEmpty {
            let errosLabel = UILabel()
            errosLabel.font = UIFont.systemFont(ofSize: 18, weight: .bold)
            errosLabel.textColor = .systemRed
            errosLabel.text = "Perguntas que você errou:"
            errosLabel.translatesAutoresizingMaskIntoConstraints = false
            containerView.addSubview(errosLabel)

            NSLayoutConstraint.activate([
                errosLabel.topAnchor.constraint(equalTo: ultimoView.bottomAnchor, constant: 32),
                errosLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
                errosLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16)
            ])

            ultimoView = errosLabel

            // Exibe cada pergunta errada
            for (index, pergunta) in viewModel.perguntasErradas.enumerated() {
                ultimoView = adicionarPerguntaErrada(
                    ao: containerView,
                    numero: index + 1,
                    pergunta: pergunta,
                    abaixoDe: ultimoView
                )
            }
        }

        // Constraint do último elemento até o fim do container
        ultimoView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -24).isActive = true

        // Botão voltar
        let botaoVoltar = UIButton(type: .system)
        botaoVoltar.setTitle("Voltar ao Início", for: .normal)
        botaoVoltar.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        botaoVoltar.backgroundColor = .systemBlue
        botaoVoltar.setTitleColor(.white, for: .normal)
        botaoVoltar.layer.cornerRadius = 8
        botaoVoltar.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(botaoVoltar)

        NSLayoutConstraint.activate([
            botaoVoltar.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16),
            botaoVoltar.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            botaoVoltar.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            botaoVoltar.heightAnchor.constraint(equalToConstant: 50)
        ])

        botaoVoltar.addTarget(self, action: #selector(voltarAoInicio), for: .touchUpInside)
    }

    /// Adiciona uma pergunta errada ao resultado
    private func adicionarPerguntaErrada(
        ao container: UIView,
        numero: Int,
        pergunta: PerguntaErrada,
        abaixoDe ultimoView: UIView
    ) -> UIView {
        // Card da pergunta
        let cardView = UIView()
        cardView.backgroundColor = .systemBackground
        cardView.layer.borderColor = UIColor.systemRed.cgColor
        cardView.layer.borderWidth = 1
        cardView.layer.cornerRadius = 8
        cardView.translatesAutoresizingMaskIntoConstraints = false
        container.addSubview(cardView)

        NSLayoutConstraint.activate([
            cardView.topAnchor.constraint(equalTo: ultimoView.bottomAnchor, constant: 16),
            cardView.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 16),
            cardView.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -16)
        ])

        // Número da pergunta
        let numeroLabel = UILabel()
        numeroLabel.font = UIFont.systemFont(ofSize: 12, weight: .semibold)
        numeroLabel.textColor = .systemRed
        numeroLabel.text = "Pergunta \(numero)"
        numeroLabel.translatesAutoresizingMaskIntoConstraints = false
        cardView.addSubview(numeroLabel)

        NSLayoutConstraint.activate([
            numeroLabel.topAnchor.constraint(equalTo: cardView.topAnchor, constant: 12),
            numeroLabel.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 12)
        ])

        // Texto da pergunta
        let perguntaLabel = UILabel()
        perguntaLabel.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        perguntaLabel.textColor = .label
        perguntaLabel.numberOfLines = 0
        perguntaLabel.text = pergunta.pergunta
        perguntaLabel.translatesAutoresizingMaskIntoConstraints = false
        cardView.addSubview(perguntaLabel)

        NSLayoutConstraint.activate([
            perguntaLabel.topAnchor.constraint(equalTo: numeroLabel.bottomAnchor, constant: 8),
            perguntaLabel.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 12),
            perguntaLabel.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -12)
        ])

        // Sua resposta (errada)
        let suaRespostaLabel = UILabel()
        suaRespostaLabel.font = UIFont.systemFont(ofSize: 13, weight: .regular)
        suaRespostaLabel.textColor = .systemRed
        suaRespostaLabel.numberOfLines = 0
        suaRespostaLabel.text = "❌ Sua resposta: \(pergunta.respostaClicada)"
        suaRespostaLabel.translatesAutoresizingMaskIntoConstraints = false
        cardView.addSubview(suaRespostaLabel)

        NSLayoutConstraint.activate([
            suaRespostaLabel.topAnchor.constraint(equalTo: perguntaLabel.bottomAnchor, constant: 12),
            suaRespostaLabel.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 12),
            suaRespostaLabel.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -12)
        ])

        // Resposta correta
        let respostaCorretaLabel = UILabel()
        respostaCorretaLabel.font = UIFont.systemFont(ofSize: 13, weight: .semibold)
        respostaCorretaLabel.textColor = .systemGreen
        respostaCorretaLabel.numberOfLines = 0
        respostaCorretaLabel.text = "✓ Resposta correta: \(pergunta.respostaCorreta)"
        respostaCorretaLabel.translatesAutoresizingMaskIntoConstraints = false
        cardView.addSubview(respostaCorretaLabel)

        NSLayoutConstraint.activate([
            respostaCorretaLabel.topAnchor.constraint(equalTo: suaRespostaLabel.bottomAnchor, constant: 8),
            respostaCorretaLabel.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 12),
            respostaCorretaLabel.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -12),
            respostaCorretaLabel.bottomAnchor.constraint(equalTo: cardView.bottomAnchor, constant: -12)
        ])

        return cardView
    }

    /// Volta para a home
    @objc private func voltarAoInicio() {
        navigationController?.popToRootViewController(animated: true)
    }
}

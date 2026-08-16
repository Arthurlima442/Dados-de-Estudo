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

        // Container principal
        let containerView = UIView()
        containerView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(containerView)

        NSLayoutConstraint.activate([
            containerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            containerView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            containerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            containerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
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
            tituloLabel.topAnchor.constraint(equalTo: containerView.topAnchor),
            tituloLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            tituloLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor)
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
            porcentagemLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            porcentagemLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor)
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
            statsLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            statsLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor)
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
            messagemLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            messagemLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            messagemLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor)
        ])

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

    /// Volta para a home
    @objc private func voltarAoInicio() {
        navigationController?.popToRootViewController(animated: true)
    }
}

import UIKit

class HomeView: UIView {

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Swift Academy"
        label.font = UIFont.systemFont(ofSize: 28, weight: .bold)
        label.textColor = .label
        label.textAlignment = .center
        return label
    }()

    private(set) var botaoQuiz: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Quiz", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        button.backgroundColor = .systemOrange
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 8
        return button
    }()

    private(set) var botaoConteudo: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Conteúdo", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        button.backgroundColor = .systemBlue
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 8
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

        addSubview(titleLabel)
        addSubview(botaoQuiz)
        addSubview(botaoConteudo)

        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        botaoQuiz.translatesAutoresizingMaskIntoConstraints = false
        botaoConteudo.translatesAutoresizingMaskIntoConstraints = false

        // Título no topo
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 40),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16)
        ])

        // Botões lado a lado (centralizados)
        NSLayoutConstraint.activate([
            botaoQuiz.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 60),
            botaoQuiz.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            botaoQuiz.trailingAnchor.constraint(equalTo: botaoConteudo.leadingAnchor, constant: -12),
            botaoQuiz.heightAnchor.constraint(equalToConstant: 60),

            botaoConteudo.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 60),
            botaoConteudo.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            botaoConteudo.widthAnchor.constraint(equalTo: botaoQuiz.widthAnchor),
            botaoConteudo.heightAnchor.constraint(equalToConstant: 60)
        ])
    }
}

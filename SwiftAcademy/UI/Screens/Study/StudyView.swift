import UIKit

class StudyView: UIView {

    // MARK: - UI Components

    private let scrollView: UIScrollView = {
        let scroll = UIScrollView()
        scroll.showsVerticalScrollIndicator = true
        return scroll
    }()

    private let contentStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 20
        stack.layoutMargins = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
        stack.isLayoutMarginsRelativeArrangement = true
        return stack
    }()

    private let explanationLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        label.textColor = .label
        label.numberOfLines = 0
        return label
    }()

    private let exampleLabel: UILabel = {
        let label = UILabel()
        label.text = "Exemplo:"
        label.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        label.textColor = .label
        return label
    }()

    private let exampleCodeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.monospacedSystemFont(ofSize: 13, weight: .regular)
        label.textColor = .label
        label.numberOfLines = 0
        label.backgroundColor = .secondarySystemBackground
        return label
    }()

    private let keyPointsLabel: UILabel = {
        let label = UILabel()
        label.text = "Pontos Importantes:"
        label.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        label.textColor = .label
        return label
    }()

    private let keyPointsStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 8
        return stack
    }()

    // MARK: - Init

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Setup

    /// Configura a interface visual com Auto Layout programático
    private func setupUI() {
        backgroundColor = .systemBackground

        addSubview(scrollView)
        scrollView.addSubview(contentStackView)

        contentStackView.addArrangedSubview(explanationLabel)
        contentStackView.addArrangedSubview(exampleLabel)
        contentStackView.addArrangedSubview(exampleCodeLabel)
        contentStackView.addArrangedSubview(keyPointsLabel)
        contentStackView.addArrangedSubview(keyPointsStackView)

        scrollView.translatesAutoresizingMaskIntoConstraints = false
        contentStackView.translatesAutoresizingMaskIntoConstraints = false
        exampleCodeLabel.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: bottomAnchor),

            contentStackView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentStackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentStackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentStackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentStackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),

            exampleCodeLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: 100)
        ])

        exampleCodeLabel.layoutMargins = UIEdgeInsets(top: 12, left: 12, bottom: 12, right: 12)
    }

    /// Preenche a view com o conteúdo de estudo (explanation, example, keyPoints)
    func configure(with content: StudyContent) {
        explanationLabel.text = content.explanation
        exampleCodeLabel.text = content.example
        setupKeyPoints(content.keyPoints)
    }

    /// Cria um label para cada ponto-chave e adiciona na stack view
    private func setupKeyPoints(_ points: [String]) {
        keyPointsStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }

        for point in points {
            let label = UILabel()
            label.text = "• \(point)"
            label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
            label.textColor = .label
            label.numberOfLines = 0
            keyPointsStackView.addArrangedSubview(label)
        }
    }
}

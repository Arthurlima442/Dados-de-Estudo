import UIKit

class TopicCell: UITableViewCell {

    static let identifier = "TopicCell"

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        label.textColor = .label
        label.numberOfLines = 1
        return label
    }()

    private let disclosureIndicator: UILabel = {
        let label = UILabel()
        label.text = "›"
        label.font = UIFont.systemFont(ofSize: 18, weight: .light)
        label.textColor = .tertiaryLabel
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    /// Configura a interface visual da célula
    private func setupUI() {
        // Adiciona os labels na célula
        contentView.addSubview(titleLabel)
        contentView.addSubview(disclosureIndicator)

        // Ativa o Auto Layout
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        disclosureIndicator.translatesAutoresizingMaskIntoConstraints = false

        // Define as constraints (posicionamento)
        NSLayoutConstraint.activate([
            titleLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: disclosureIndicator.leadingAnchor, constant: -8),

            disclosureIndicator.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            disclosureIndicator.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16)
        ])

        // Remove o efeito de seleção padrão
        self.selectionStyle = .none
    }

    /// Preenche a célula com dados de um tópico
    func configure(with topic: Topic) {
        titleLabel.text = topic.title
    }
}

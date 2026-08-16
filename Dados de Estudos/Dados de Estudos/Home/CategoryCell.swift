import UIKit

class CategoryCell: UITableViewCell {

    static let identifier = "CategoryCell"

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        label.textColor = .label
        label.numberOfLines = 1
        return label
    }()

    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.textColor = .secondaryLabel
        label.numberOfLines = 1
        return label
    }()

    private let disclosureIndicator: UILabel = {
        let label = UILabel()
        label.text = "›"
        label.font = UIFont.systemFont(ofSize: 20, weight: .light)
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
        contentView.addSubview(descriptionLabel)
        contentView.addSubview(disclosureIndicator)

        // Ativa o Auto Layout
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        disclosureIndicator.translatesAutoresizingMaskIntoConstraints = false

        // Define as constraints (posicionamento)
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: disclosureIndicator.leadingAnchor, constant: -8),

            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 4),
            descriptionLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            descriptionLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
            descriptionLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -12),

            disclosureIndicator.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            disclosureIndicator.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16)
        ])

        // Remove o efeito de seleção padrão
        self.selectionStyle = .none
    }

    /// Preenche a célula com dados de uma categoria
    func configure(with category: Category) {
        titleLabel.text = category.title
        descriptionLabel.text = category.description
    }
}

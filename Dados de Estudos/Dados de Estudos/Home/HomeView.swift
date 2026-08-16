import UIKit

class HomeView: UIView {

    private(set) var tableView: UITableView = {
        let table = UITableView(frame: .zero, style: .plain)
        table.backgroundColor = .systemBackground
        table.separatorStyle = .singleLine
        table.rowHeight = UITableView.automaticDimension
        table.estimatedRowHeight = 80
        return table
    }()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Swift Academy"
        label.font = UIFont.systemFont(ofSize: 28, weight: .bold)
        label.textColor = .label
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    /// Configura a interface visual com Auto Layout
    private func setupUI() {
        // Define a cor de fundo
        backgroundColor = .systemBackground

        // Adiciona os elementos na view
        addSubview(titleLabel)
        addSubview(tableView)

        // Ativa o Auto Layout
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        tableView.translatesAutoresizingMaskIntoConstraints = false

        // Define as constraints (posicionamento)
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 16),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),

            tableView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 24),
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])

        // Registra a célula para reutilização
        tableView.register(CategoryCell.self, forCellReuseIdentifier: CategoryCell.identifier)
    }
}

# Swift Academy - Documentação Completa

## 📱 Visão Geral do Projeto

**Swift Academy** é um aplicativo iOS educacional para estudar conceitos de Swift de forma organizada e progressiva. O app funciona como um "Duolingo para Swift", permitindo o aprendizado através de categorias, tópicos e conteúdo estruturado.

### Objetivos:
- ✅ Aprender desenvolvimento iOS durante o desenvolvimento do app
- ✅ Entender arquitetura MVVM na prática
- ✅ Código simples, organizado e reutilizável
- ✅ Fácil adicionar novos conteúdos de estudo

---

## 🏗️ Arquitetura MVVM

O projeto segue o padrão **MVVM (Model-View-ViewModel)** rigorosamente:

```
┌─────────────────┐
│     Model       │ ← Dados puros (Category, Topic, StudyContent)
└────────┬────────┘
         ↓
┌─────────────────┐
│    Service      │ ← Carrega dados (DataService)
└────────┬────────┘
         ↓
┌─────────────────┐
│   ViewModel     │ ← Processa dados (HomeViewModel, etc)
└────────┬────────┘
         ↓
┌─────────────────┐
│  ViewController │ ← Exibe na tela (HomeViewController, etc)
└────────┬────────┘
         ↓
┌─────────────────┐
│      View       │ ← Interface visual (HomeView, etc)
└─────────────────┘
```

### Regras Importantes:

✅ **ViewController:**
- Apenas cria UI
- Chama ViewModel
- Não contém lógica de negócio

✅ **ViewModel:**
- Processa dados
- Fornece dados prontos
- Não sabe sobre UIKit

✅ **Service:**
- Carrega dados
- Não contém lógica de negócio

---

## 📁 Estrutura de Pastas

```
SwiftAcademy/
│
├── Core/
│   ├── Models/
│   │   ├── Category.swift          (Categoria de estudo)
│   │   ├── Topic.swift             (Tópico dentro categoria)
│   │   └── StudyContent.swift      (Conteúdo de estudo)
│   │
│   ├── Services/
│   │   └── DataService.swift       (Carrega JSON)
│   │
│   └── ViewModels/
│       ├── HomeViewModel.swift     (Controla home)
│       ├── CategoryDetailViewModel.swift (Controla category)
│       └── StudyViewModel.swift    (Controla study)
│
├── UI/
│   └── Screens/
│       ├── Home/
│       │   ├── HomeView.swift
│       │   ├── HomeViewController.swift
│       │   └── CategoryCell.swift
│       │
│       ├── CategoryDetail/
│       │   ├── CategoryDetailView.swift
│       │   ├── CategoryDetailViewController.swift
│       │   └── TopicCell.swift
│       │
│       └── Study/
│           ├── StudyView.swift
│           └── StudyViewController.swift
│
├── Resources/
│   ├── Assets.xcassets
│   └── JSON/
│       └── studyData.json          (Dados de estudo)
│
├── AppDelegate.swift
└── SceneDelegate.swift
```

---

## 📊 Models (Dados)

### **Category.swift**
Representa uma categoria de estudo.

```swift
struct Category: Codable {
    let id: String                  // "fundamentos"
    let title: String               // "Fundamentos"
    let description: String         // "Conceitos básicos de Swift"
    let topics: [Topic]            // Array de tópicos
}
```

**Responsabilidade:** Guardar informações da categoria

---

### **Topic.swift**
Representa um tópico dentro de uma categoria.

```swift
struct Topic: Codable {
    let id: String                  // "variaveis"
    let title: String               // "Variáveis"
    let content: StudyContent       // Conteúdo de estudo
}
```

**Responsabilidade:** Guardar informações do tópico

---

### **StudyContent.swift**
Representa o conteúdo real de estudo.

```swift
struct StudyContent: Codable {
    let explanation: String         // "Uma variável é..."
    let example: String            // "var idade = 25"
    let keyPoints: [String]        // ["Mutável", "Tipo inferido"]
}
```

**Responsabilidade:** Guardar dados de estudo

---

## 🔌 Services (Carregar Dados)

### **DataService.swift**
Responsável por carregar o arquivo JSON e decodificar em Models.

**Funções principais:**

| Função | O que faz | Retorna |
|--------|-----------|---------|
| `loadCategories()` | Carrega JSON e decodifica | `[Category]` |

**Fluxo:**
1. Encontra arquivo `studyData.json` no bundle
2. Lê o arquivo como `Data` (bytes)
3. Decodifica JSON em Models Swift
4. Retorna array de categorias

**Por que é importante:**
- Centraliza o carregamento de dados
- Fácil de testar (usar mock)
- Isolado da lógica da aplicação

---

## 🧠 ViewModels (Lógica)

### **HomeViewModel.swift**
Gerencia dados da tela inicial.

| Função | O que faz | Retorna |
|--------|-----------|---------|
| `loadCategories()` | Carrega categorias do Service | Void |
| `numberOfCategories()` | Retorna quantidade de categorias | Int |
| `category(at:)` | Retorna categoria específica | Category? |

**Fluxo:**
1. HomeViewController chama `loadCategories()`
2. ViewModel chama DataService
3. Service retorna array de categorias
4. ViewModel armazena em `self.categories`
5. ViewController lê `self.categories` e exibe na tela

---

### **CategoryDetailViewModel.swift**
Gerencia dados de uma categoria específica.

| Função | O que faz | Retorna |
|--------|-----------|---------|
| `categoryTitle()` | Retorna título | String |
| `categoryDescription()` | Retorna descrição | String |
| `numberOfTopics()` | Retorna quantidade de tópicos | Int |
| `topic(at:)` | Retorna tópico específico | Topic? |

**Diferença do HomeViewModel:**
- Recebe a categoria no `init()`
- Não carrega do Service (já foi carregado)
- Apenas fornece dados da categoria

---

### **StudyViewModel.swift**
Gerencia dados de um tópico de estudo.

| Função | O que faz | Retorna |
|--------|-----------|---------|
| `topicTitle()` | Retorna título | String |
| `explanation()` | Retorna explicação | String |
| `example()` | Retorna exemplo | String |
| `keyPoints()` | Retorna pontos-chave | [String] |
| `content()` | Retorna conteúdo completo | StudyContent |

**Diferença dos outros:**
- Recebe o tópico no `init()`
- Apenas fornece dados do tópico
- Sem processamento complexo

---

## 🎨 Views (Interface)

### **HomeView.swift**
Cria a interface visual da tela inicial.

**Componentes:**
- `titleLabel` - "Swift Academy" no topo
- `tableView` - Lista de categorias

**Responsabilidade:**
- Apenas criar e posicionar elementos
- Não contém lógica

---

### **CategoryDetailView.swift**
Cria a interface da tela de categoria.

**Componentes:**
- `descriptionLabel` - Descrição da categoria
- `tableView` - Lista de tópicos

**Responsabilidade:**
- Apenas criar e posicionar elementos
- Método `setDescription()` para preencher dados

---

### **StudyView.swift**
Cria a interface da tela de estudo.

**Componentes:**
- `explanationLabel` - Explicação do conceito
- `exampleCodeLabel` - Código de exemplo
- `keyPointsStackView` - Lista de pontos importantes

**Responsabilidade:**
- Apenas criar e posicionar elementos
- Método `configure()` para preencher dados

---

## 📱 ViewControllers (Controle)

### **HomeViewController.swift**
Controla a tela inicial.

**Funções principais:**

| Função | O que faz |
|--------|-----------|
| `loadView()` | Carrega a HomeView |
| `viewDidLoad()` | Configura e carrega dados |
| `setupTableView()` | Configura delegate/dataSource |
| `loadData()` | Chama ViewModel para carregar |
| `tableView(numberOfRowsInSection:)` | Retorna quantidade de linhas |
| `tableView(cellForRowAt:)` | Cria e configura cada célula |
| `tableView(didSelectRowAt:)` | Navega para categoria |

**Fluxo:**
1. `viewDidLoad()` - Configura tudo
2. `setupTableView()` - Define delegate
3. `loadData()` - Carrega do ViewModel
4. UITableView chama `numberOfRowsInSection()`
5. UITableView chama `cellForRowAt()` para cada linha
6. Usuário toca em célula → `didSelectRowAt()` navega

---

### **CategoryDetailViewController.swift**
Controla a tela de categoria.

**Funções principais:**

| Função | O que faz |
|--------|-----------|
| `loadView()` | Carrega a CategoryDetailView |
| `viewDidLoad()` | Configura e carrega dados |
| `setupUI()` | Define título |
| `setupTableView()` | Configura delegate/dataSource |
| `loadData()` | Preenche view com dados |
| `tableView(numberOfRowsInSection:)` | Retorna quantidade de tópicos |
| `tableView(cellForRowAt:)` | Cria célula do tópico |
| `tableView(didSelectRowAt:)` | Navega para estudo |

---

### **StudyViewController.swift**
Controla a tela de estudo.

**Funções principais:**

| Função | O que faz |
|--------|-----------|
| `loadView()` | Carrega a StudyView |
| `viewDidLoad()` | Configura e carrega dados |
| `setupUI()` | Define título |
| `loadData()` | Preenche view com conteúdo |

---

## 🔲 Cells (Linhas da Tabela)

### **CategoryCell.swift**
Célula que exibe uma categoria.

**Componentes:**
- `titleLabel` - Nome da categoria
- `descriptionLabel` - Descrição
- `disclosureIndicator` - Seta "›"

**Reutilização:**
- `register()` no Home View
- `dequeueReusableCell()` no Home ViewController

---

### **TopicCell.swift**
Célula que exibe um tópico.

**Componentes:**
- `titleLabel` - Nome do tópico
- `disclosureIndicator` - Seta "›"

**Reutilização:**
- `register()` na Category Detail View
- `dequeueReusableCell()` na Category Detail ViewController

---

## 📄 JSON (Dados)

### **studyData.json**
Arquivo com todos os dados de estudo.

**Estrutura:**
```json
{
  "categories": [
    {
      "id": "fundamentos",
      "title": "Fundamentos",
      "description": "Conceitos básicos de Swift",
      "topics": [
        {
          "id": "variaveis",
          "title": "Variáveis",
          "content": {
            "explanation": "...",
            "example": "...",
            "keyPoints": [...]
          }
        }
      ]
    }
  ]
}
```

**Dados Inclusos:**
- ✅ 11 Categorias
- ✅ 35+ Tópicos
- ✅ Conteúdo pronto para estudar

---

## 🔄 Fluxo da Aplicação

```
1. App Inicia
   ↓
2. SceneDelegate configura HomeViewController
   ↓
3. HomeViewController.viewDidLoad()
   ├─ setupTableView()
   ├─ loadData() → HomeViewModel.loadCategories()
   │   └─ DataService.loadCategories() → Lê JSON
   ├─ homeView.tableView.reloadData()
   ↓
4. UITableView exibe categorias
   ├─ numberOfRowsInSection() → Retorna 11
   ├─ cellForRowAt() → Cria 11 CategoryCells
   ↓
5. Usuário toca em categoria (ex: "Fundamentos")
   ↓
6. didSelectRowAt() navega para CategoryDetailViewController
   ├─ Cria CategoryDetailViewModel com categoria selecionada
   ├─ CategoryDetailViewController.viewDidLoad()
   │   └─ loadData() → CategoryDetailView exibe tópicos
   ↓
7. UITableView exibe tópicos da categoria
   ├─ numberOfRowsInSection() → Retorna quantidade de tópicos
   ├─ cellForRowAt() → Cria TopicCells
   ↓
8. Usuário toca em tópico (ex: "Variáveis")
   ↓
9. didSelectRowAt() navega para StudyViewController
   ├─ Cria StudyViewModel com tópico selecionado
   ├─ StudyViewController.viewDidLoad()
   │   └─ loadData() → StudyView exibe conteúdo
   ↓
10. Usuário estuda o conteúdo
```

---

## ➕ Como Adicionar Novo Conteúdo

### **Passo 1: Editar `studyData.json`**

Adicione uma nova categoria ou tópico:

```json
{
  "categories": [
    {
      "id": "sua_categoria",
      "title": "Título da Categoria",
      "description": "Descrição breve",
      "topics": [
        {
          "id": "seu_topico",
          "title": "Título do Tópico",
          "content": {
            "explanation": "Explicação clara e objetiva",
            "example": "let exemplo = \"seu código aqui\"",
            "keyPoints": [
              "Ponto 1",
              "Ponto 2",
              "Ponto 3"
            ]
          }
        }
      ]
    }
  ]
}
```

### **Passo 2: Rebuild do App**

```bash
Command + Shift + K (limpar build)
Command + B (compilar)
Command + R (rodar)
```

**Pronto!** O novo conteúdo aparecerá automaticamente no app.

---

## 📚 Conceitos iOS Aprendidos

### **1. MVVM Architecture**
- Separação de responsabilidades
- ViewModel não sabe sobre UIKit
- ViewController apenas exibe dados

### **2. Auto Layout Programático**
- `translatesAutoresizingMaskIntoConstraints = false`
- `NSLayoutConstraint.activate()`
- Constraints de espaçamento e alinhamento

### **3. UITableView**
- `DataSource` → Dados
- `Delegate` → Eventos
- `dequeueReusableCell()` → Reutilização

### **4. Codable**
- `struct: Codable`
- `JSONDecoder().decode()`
- Parsing automático de JSON

### **5. Bundle Resources**
- `Bundle.main.url(forResource:withExtension:)`
- Acessar arquivos do app

### **6. Navigation**
- `navigationController?.pushViewController()`
- Pilha de ViewControllers

### **7. View Hierarchy**
- `addSubview()` → Adicionar views
- `layoutMargins`, `padding`
- Organização visual

### **8. Protocol**
- `DataServiceProtocol` → Contrato
- Abstração e testabilidade

### **9. StackView**
- `UIStackView` → Layout automático
- `arrangedSubviews` → Organizar views
- Espaçamento automático

### **10. Type Safety**
- Swift é fortemente tipado
- Guards e Optionals
- Segurança em tempo de compilação

---

## 🎓 O que Você Aprendeu

✅ Arquitetura MVVM na prática
✅ ViewCode (Interface Programática)
✅ Auto Layout sem Storyboard
✅ Estrutura de dados com Codable
✅ Carregamento de JSON
✅ UITableView avançado
✅ Navegação entre telas
✅ Boas práticas de código
✅ Organização de pastas
✅ Padrões de design iOS

---

## 🚀 Próximos Passos

1. **Adicionar mais conteúdo** ao `studyData.json`
2. **Persistência** - Salvar progresso com UserDefaults
3. **Animações** - Transições suaves entre telas
4. **Search** - Buscar tópicos
5. **Temas** - Light/Dark mode
6. **Compartilhamento** - Compartilhar conteúdo
7. **Testes** - Unit tests do ViewModel
8. **Performance** - Lazy loading de imagens

---

## 📖 Estrutura de Aprendizado Recomendada

### **Iniciante:**
1. Ler esta documentação
2. Explorar Models (Category, Topic, StudyContent)
3. Entender DataService
4. Ver como ViewController usa ViewModel

### **Intermediário:**
1. Adicionar novo conteúdo ao JSON
2. Modificar Views (cores, fonts)
3. Adicionar novos tópicos
4. Experimentar com Auto Layout

### **Avançado:**
1. Adicionar persistência com UserDefaults
2. Criar novos ViewModels
3. Adicionar animações
4. Escrever testes

---

## 💡 Dicas para Entrevistas

1. **Explique o fluxo:** "Quando o usuário toca em uma categoria, o app cria um novo ViewController com um ViewModel..."

2. **Fale sobre MVVM:** "A ViewModel não sabe sobre UIKit, ela apenas processa dados..."

3. **Mencione o JSON:** "Adicionei um sistema onde os dados vêm de um JSON local, facilitando adicionar novos conteúdos..."

4. **Destaque Auto Layout:** "Usei Auto Layout programático para ter mais controle e aprender como funciona..."

5. **Fale sobre reutilização:** "As Cells são reutilizadas pela UITableView para performance..."

---

## 📞 Troubleshooting

### Problema: "Arquivo JSON não encontrado"
**Solução:** Verifique se `studyData.json` está em `Copy Bundle Resources` nas Build Phases do Xcode.

### Problema: "Tela em branco"
**Solução:** Verifique se o SceneDelegate está configurado corretamente para criar HomeViewController.

### Problema: "Dados não carregam"
**Solução:** Verifique se o JSON é válido (sem comentários, aspas duplas, etc).

---

## ✅ Checklist Antes de Entrevista

- [ ] Li toda a documentação
- [ ] Entendo o fluxo MVVM
- [ ] Consigo explicar cada arquivo
- [ ] Testei adicionar novo conteúdo
- [ ] Consegui rodar o app sem erros
- [ ] Explorei o código de cada classe
- [ ] Entendo Auto Layout
- [ ] Consigo explicar UITableView
- [ ] Sou capaz de modificar o projeto
- [ ] Tenho exemplos de código para citar

---

**Desenvolvido com ❤️ para aprender iOS**

Última atualização: 16 de Agosto de 2026

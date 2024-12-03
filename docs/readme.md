# Kuruma Interpreter

**Kuruma** é um interpretador simples desenvolvido em Lua para executar arquivos em uma linguagem personalizada chamada **Kuruma**. Ele permite que você crie scripts com comandos básicos, como a definição e chamada de funções, além de exibir mensagens no terminal.

O projeto é ideal para quem está começando a explorar a criação de interpretadores ou quer uma base para criar sua própria linguagem de programação.

## Estrutura do Projeto

```
kuruma/
├── src/
│   └── interpretador.lua       # Arquivo principal do interpretador
├── exemplos/
│   └── olamundo.krm            # Exemplo de script Kuruma
├── docs/
│   └── readme.md               # Documentação do projeto
├── testes/
│   └── teste_basico.krm        # Arquivo para testes simples
└── .gitignore                  # Arquivos ignorados pelo Git
```

## Recursos da Linguagem Kuruma

### Comandos Suportados:
1. **`escreva`**: Exibe mensagens no terminal.
   ```kuruma
   escreva("Olá, Mundo!")
   ```

2. **Definição de funções**:
   ```kuruma
   funcao saudacao(nome)
       escreva("Olá, " .. nome)
   fim
   ```

3. **Chamada de funções**:
   ```kuruma
   saudacao("Mundo")
   ```

## Como Usar

### Requisitos:
- **Lua 5.4** ou superior.

### Passos:
1. Clone o repositório:
   ```bash
   git clone https://github.com/Maeda1744/Kuruma_interpreter.git
   cd Kuruma_interpreter
   ```
2. Crie ou edite arquivos `.krm` na pasta `exemplos/`.
3. Execute o interpretador passando o caminho do arquivo `.krm` como argumento:
   ```bash
   lua src/interpretador.lua exemplos/olamundo.krm
   ```

### Exemplo de Saída:
Arquivo `olamundo.krm`:
```kuruma
funcao saudacao(nome)
    escreva("Olá, " .. nome)
fim

saudacao("Mundo")
```

Saída no terminal:
```
Olá, Mundo
```

## Contribuindo

Se você deseja contribuir, sinta-se à vontade para abrir **issues** ou enviar um **pull request**. Toda ajuda é bem-vinda. Obrigado

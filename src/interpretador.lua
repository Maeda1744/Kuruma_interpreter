local funcoes = {}

-- Função para ler o conteúdo do arquivo
local function lerArquivo(caminho)
    local arquivo = io.open(caminho, "r")
    if not arquivo then
        error("Não foi possível abrir o arquivo: " .. caminho)
    end
    local conteudo = arquivo:read("*a")
    arquivo:close()
    return conteudo
end

-- Função para definir funções no interpretador
local function definirFuncao(nome, parametros, corpo)
    funcoes[nome] = { parametros = parametros, corpo = corpo }
end

-- Função para chamar funções definidas
local function chamarFuncao(nome, argumentos)
    local func = funcoes[nome]
    if func then
        local parametros = func.parametros
        -- Criar um novo ambiente para a função
        local func_env = {
            escreva = function(msg) print(msg) end -- Função escreva global
        }

        -- Passa os parâmetros da função para o ambiente
        for i, param in ipairs(parametros) do
            func_env[param] = argumentos[i]
        end

        -- Carregar e executar o corpo da função no novo ambiente
        local func_code = "return " .. func.corpo
        local func_chunk = load(func_code, "funcao_" .. nome, "t", func_env)
        if func_chunk then
            func_chunk()
        else
            error("Erro ao executar a função " .. nome)
        end
    else
        error("Função " .. nome .. " não definida.")
    end
end

-- Função para dividir a string de parâmetros (caso haja mais de um)
function split(str, sep)
    local result = {}
    for match in (str..sep):gmatch("(.-)"..sep) do
        table.insert(result, match)
    end
    return result
end

-- Função principal de interpretação do código cuidado ao alterar algo aqui.
local function interpretar(codigo)
    local dentroFuncao = false
    local funcaoNome, funcaoParametros, funcaoCorpo = nil, nil, ""

    for linha in codigo:gmatch("[^\r\n]+") do
        if dentroFuncao then
            if linha:match("^fim$") then
                definirFuncao(funcaoNome, funcaoParametros, funcaoCorpo)
                dentroFuncao = false
                funcaoNome, funcaoParametros, funcaoCorpo = nil, nil, ""
            else
                funcaoCorpo = funcaoCorpo .. linha .. "\n"
            end
        elseif linha:match("^funcao%s+[%a_][%w_]*%(") then
            -- Detecta a definição de função
            funcaoNome, funcaoParametros = linha:match("^funcao%s+(%a[%w_]*)(%b())$")
            funcaoParametros = split(funcaoParametros:sub(2, -2), ",")  -- Separar parâmetros
            dentroFuncao = true
        elseif linha:match("^escreva%(.+%)$") then
            -- Comando 'escreva'
            local mensagem = linha:match("^escreva%((.+)%)$")
            print(load("return " .. mensagem)())
        elseif linha:match("^%a[%w_]*%(.+%)$") then
            -- Detecta chamada de função
            local nome, argumentos = linha:match("^(%a[%w_]*)(%b())$")
            argumentos = split(argumentos:sub(2, -2), ",")  -- Separar argumentos
            for i, arg in ipairs(argumentos) do
                argumentos[i] = load("return " .. arg)()  -- Avalia cada argumento
            end
            chamarFuncao(nome, argumentos)
        else
            print("Comando desconhecido: " .. linha)
        end
    end
end

local caminhoArquivo = arg[1]
if not caminhoArquivo then
    print("Uso: lua interpretador.lua <caminho do arquivo .krm>")
else
    local codigoKuruma = lerArquivo(caminhoArquivo)
    interpretar(codigoKuruma)
end

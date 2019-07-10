sudokuList = require 'sudokuList'

math.randomseed(os.time())

sudoku = {}

function sudoku:criar (tamanho)
    for i = 1, tamanho do
        self[i] = {}
        for j = 1, tamanho do
            self[i][j] = {valor = 0, constante = false}
        end
    end
end

function sudoku:novo()
    sudoku:criar(9)
    sudoku:preenchimentoInicial()
end

function sudoku:preenchimentoInicial()
    value = sudokuList[math.random(#sudokuList)] --seleciona aleatóriamente um sudoku da lista de sudokus
    k = 1
    for i = 1, #self do
        for j = 1, #self do
            self[i][j].valor = value[k]
            self[i][j].constante = value[k] ~= 0 and true or false
            k = k + 1
        end
    end
end

function sudoku:posicaoLivre() --verifica se existe alguma posição livre na matriz ou seja igual 0
    for i = 1, #self do
        for j = 1, #self do
            if(self[i][j].valor == 0) then
                return true
            end
        end
    end
    return false
end

function sudoku:verificar()
    for i = 1, #self do
        for j = 1, #self do
            if(sudoku:valorInvalido(i,j)) then
                return false
            end
        end
    end
    return  true
end

function sudoku:valorInvalido(lin, col)
    for i = 1, #self do
        if(self[i][col].valor == self[lin][col].valor) then
            if(i == lin) then
            else
                return true
            end
        end
    end
    for j = 1, #self do
        if(self[lin][j].valor == self[lin][col].valor) then
            if(j == col) then
            else
                return true
            end
        end
    end
    return false
end

function sudoku:adicionar(i,j)
    if(not(self[i][j].constante)) then
        self[i][j].valor = self[i][j].valor + 1
        if(self[i][j].valor == 10) then
            self[i][j].valor = 0
        end
    end
end

function sudoku:mostrar()
    for i = 1, #self do
        for j = 1, #self do
            io.write(self[i][j].valor == 0 and '[ ]' or '['..self[i][j].valor..']')
        end
        io.write('\n')
    end
end

return sudoku
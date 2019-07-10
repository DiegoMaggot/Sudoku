colors = {
    white = {0.78, 0.97, 0.97},
    turquesa = {0, 0.80, 0.81, 0.6},
    cyan = {0, 0.54, 0.54},
    gray = {237/255, 235/255, 233/255}
}
--variaveis
tableChanged = false
canClick = false

local background = display.newRect(display.contentCenterX, display.contentCenterY, 800, 800)
background.fill = colors.gray

tableGroup = display.newGroup()
tableGroup.x, tableGroup.y = -3, -15

tableRect = display.newRect(tableGroup, 165, 245, 330, 335)
tableRect.fill = colors.turquesa

showMsg = display.newText('', 165, 40, "sudokuFont", 20)
showMsg:setFillColor(26/255, 188/255, 156/255)

function avaliate( event )
    if(canClick) then
        avaliated = false
        if(tableChanged) then
            if(sudoku:posicaoLivre()) then
                msg = 'preencha todos os campos'
            else
                avaliated = sudoku:verificar()
                msg = avaliated and 'sudoku concluído parabéns' or 'Existem valores duplicados'
            end
            showMsg.text = msg
            showSudoku(sudoku, avaliated)
            if(avaliated) then
                canClick = false
            end
        end
    end
end

function newText(group, x, y, text, value)
    rect = display.newRoundedRect(group, x, y, 100, 50, 5)
    rect.fill = colors.white
    rect.value = display.newText(value, x + group.x, y + group.y, "sudokuFont", 22)
    rect.value:setFillColor(26/255, 188/255, 156/255)
    if(text ~= nil) then
        campoText = display.newText(text, x + group.x, group.y - 72, "sudokuFont", 30)
        campoText:setFillColor(26/255, 188/255, 156/255)
    else
        rect:addEventListener("touch", avaliate)
    end
end

tabela = display.newText("SUD    KU", 157, -10, "sudokuFont", 50)
tabela:setFillColor(26/255, 188/255, 156/255)

local function rotateEffect()
    if ( reverse == 0 ) then
        reverse = 1
        transition.to( newButton, { rotation=360, time=900, transition=easing.inOutCubic } )
    else
        reverse = 0
        transition.to( newButton, { rotation=-360, time=900, transition=easing.inOutCubic } )
    end
end

---new game
function newGame( event )
	if(not(canClick)) then
        canClick = true
    end
    showMsg.text = ''
    sudoku:novo()
    showSudoku(sudoku)
    rotateEffect()
    tableChanged = false
end
--new game button
newX, newY = 175, -10
newButton = display.newImage("icons/refresh.png", newX, newY)
newButton.rotation = -45
local reverse = 1

newButton:addEventListener("tap", newGame)

-----------------------click--------------
local function clickEvent( event )
	if(canClick) then
		if(not(tableChanged)) then
			tableChanged = true
        end
        showMsg.text = ''
		i, j = event.target.i, event.target.j
		sudoku:adicionar(i,j)
		showSudoku(sudoku)
	end
end

function newRect(group, i, j, x, y, width, height, color)
    local rect = nil
        rect = display.newRoundedRect(group, x, y, width, height,2)
        rect.fill, rect.i, rect.j = color, i, j
        rect.value = display.newText("", x + tableGroup.x, y + tableGroup.y, "sudokuFont", 20)
        rect:addEventListener("tap", clickEvent)
        rect.value:setFillColor(0, 0.54, 0.54)
    return rect
end
-----------------------click--------------

function tableView()
    posX, posY, pecaSize = -12, 100, 33
    for i = 1, 9 do
        value = 0
        for j = 1, 9 do
            rect = newRect(tableGroup, i, j, posX + 35 * j, posY, pecaSize, pecaSize, colors.white)
        end
        posY = posY + pecaSize + 3
    end
end
tableView()

function showSudoku(sudoku, avaliated)
    local k = 2
    for i = 1, #sudoku do
        for j = 1, #sudoku do
            if (sudoku[i][j].valor == 0) then
                tableGroup[k].fill = colors.white
                tableGroup[k].value:setFillColor(0, 0.54, 0.54)
                tableGroup[k].value.text = ""
            else
                tableGroup[k].value.text = sudoku[i][j].valor
                tableGroup[k].fill = colors.white
                tableGroup[k].value:setFillColor(0, 0.54, 0.54)
                if(sudoku:valorInvalido(i, j) and avaliated == false) then
                    tableGroup[k].value:setFillColor(242/255, 9/255, 9/255)
                end
            end
            k = k + 1
        end
    end
end

newText(tableGroup, 160, 480, nil, "Avaliar")

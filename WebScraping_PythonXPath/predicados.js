// Extrae un div en específico seleccionandolo según su posición en la jerarquía 
$x('/html/body/div/div[1]')

// Extrae el último div
$x('/html/body/div/div[last()]')

// Extrae todos los span con un atributo específico (EJ: de tipo class)
$x('//span[@class]')

// Extrae todos los span con un atributo específico (EJ: de tipo class) que contenga texto
$x('//span[@class]/text()').map(x => x.wholeText)
// Ir a la raíz. O agregar despues para seleccionar un nodo
$x('/')

// Salto entre nodos
$x('//')

// Ir directo al nodo
$x('//h1')

// Extraer directo del nodo en Python
$x('//h1/text()')

// Extraer directo del nodo en JS
$x('//h1/a/text()').map(x => x.wholeText)

// Accede al nodo padre
$x('//span/..')

// Acceder a todos los padres del nodo 
$x('//span').map(x => x.parentElement)

// Extrae los span con atributo class
$x('//span/@class')
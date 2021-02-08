def conversor(tipo_pesos, valor_dolar):
    pesos = input('¿Cuántos pesos ' + tipo_pesos + ' tienes?: ')
    pesos = float(pesos)
    dolares = pesos / valor_dolar
    dolares = round(dolares, 2)
    dolares = str(dolares)
    print('Tienes $' + dolares + ' dólares')

menu = """
Bienvenido al conversor de monedas

1 - Pesos chilenos
2 - Pesos colombianos
3 - Pesos argentinos

Elige una opción: """

opcion = input(menu)
if opcion == '1':
    conversor('chilenos', 768)
elif opcion == '2':
    conversor('colombianos', 3607)
elif opcion == '3':
    conversor('argenitnos', 81)
else:
    print('Ingresa una opción correcta por favor')
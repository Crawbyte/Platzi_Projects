def run():
    mi_diccionario = {
        'llave1': 1,
        'llave2': 2,
        'llave3': 3,
    }
#    print(mi_diccionario['llave1'])
#    print(mi_diccionario['llave2'])
#    print(mi_diccionario['llave3'])    
    poblacion_paises = {
        'Argentina': 123546851,
        'Brasil': 4543546843,
        'Colombia': 7543215,
    }
    for pais in poblacion_paises.keys():
        print(pais)


if __name__ == '__main__':
    run()
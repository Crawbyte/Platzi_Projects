user_01_name = input('¿Cuál es tu nombre?')
user_01_age = int(input('¿Cuál es tu edad? '))
user_02_name = input('¿Cuál es tu nombre?')
user_02_age = int(input('¿Cuál es tu edad? '))

if user_01_age > user_02_age:
    print(user_01_name + 'es mayor que ' + user_02_name)
elif user_01_age < user_02_age:
    print(user_01_name + 'es menor que ' + user_02_name)
else: 
    print('Ambos tienen la misma edad')
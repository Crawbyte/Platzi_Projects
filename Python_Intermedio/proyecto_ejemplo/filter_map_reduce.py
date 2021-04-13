my_list = [1,4,5,6,9,13,19,21]
odd = list(filter(lambda x: x%2 != 0, my_list))
print(odd)
  
  
squares = [i**2 for i in range(1, 6)]
print(squares)
  
  
my_list = range(1,6)
squares = list(map(lambda x: x**2, my_list))
print(squares)
  
  
from functools import reduce
  
my_list = [2,2,2,2,2]
multiplied = reduce(lambda a, b: a*b, my_list)
print(multiplied)
  
  
if __main__ == '__main__':
main()

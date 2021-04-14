def read():
    numbers = []
    with open("./Python_Intermedio/proyecto_ejemplo/files/numbers.txt", "r", encoding="utf-8") as f:
        for line in f:
            numbers.append(int(line))
    print(numbers)


def write():
    names = ["Facundo","Miguel","Pepe","Christian","Rocío"]
    with open("./Python_Intermedio/proyecto_ejemplo/files/names.txt", "w", encoding="utf-8") as f:
        for name in names:
            f.write(name)
            f.write("\n")


def run():
    write()


if __name__ == '__main__':
    run()
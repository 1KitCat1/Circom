# Open a file in write mode
with open('output.txt', 'w') as file:
    file.write('{"in" : [')
    for item in range(800000):
        file.write("0,")
    file.write("]}")


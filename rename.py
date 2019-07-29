import sys
filename = sys.argv[1]
while True:
    if len(filename[:-4]) < 4:
        filename = '0' + filename
    else:
        break
print(filename, end='')

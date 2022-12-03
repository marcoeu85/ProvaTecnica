import os

Dir = input('Inserisci una directory \n')
count = 0
contaInDir = 0
prefixPath = ""

for item in os.listdir(Dir): # Iterate directory
    contaInDir = 0
    prefixPath = ""
    if os.path.isfile(os.path.join(Dir, item)): # is a file
        count += 1
        #prefixPath = os.path.join(Dir)
    if os.path.isdir(os.path.join(Dir, item)): # is a subfolder
        prefixPath = os.path.join(Dir , item)
        for subfolder in os.listdir(os.path.join(Dir, item)):
            if os.path.isfile(os.path.join(prefixPath, subfolder)):
                contaInDir += 1
        print(contaInDir, " #!" + prefixPath)
print(count, " #!" + Dir)

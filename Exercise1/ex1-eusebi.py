import os
Dir = input('Inserisci una directory \n')
Find = input('Inserisci una parola da sostituire \n')
Replace =  input('Inserisci la parola sostitutiva \n')

for file in os.listdir(Dir):
    with open(os.path.join(Dir, file), 'r') as file_r:
        filedata = file_r.read()
    filedata = filedata.replace(Find, Replace)
    with open(os.path.join(Dir, file), 'w') as file_w:
        file_w.write(filedata)

print("Process completed !") 

import sys
import random

lang1=str(sys.argv[1])
lang2=str(sys.argv[2])
seed=str(sys.argv[3])
f=str(sys.argv[4])

ff1=open('train-dict/seed-{0}-{1}-{2}.train80.txt'.format(seed,lang1,lang2),'w',encoding='utf-8')
ff1=open('train-dict/seed-{0}-{1}-{2}.train20.txt'.format(seed,lang1,lang2),'w',encoding='utf-8')

dict1=[]
for line in f:
    vals=line.split()
    if len(vals)==2:
        dict1.append([vals[0].strip(),vals[1].strip()])

random.Random(int(sys.argv[5])).shuffle(dict1)
dict_size=len(dict1)
dict11=dict1[:int(0.8*dict_size)]
dict12=dict1[int(0.8*dict_size):]

for vals in dict11:
    ff1.write(vals[0].strip()+' '+vals[1].strip()+'\n')

for vals in dict12:
    ff2.write(vals[0].strip()+' '+vals[1].strip()+'\n')

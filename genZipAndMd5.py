#coding:utf8
import zipfile
import hashlib
import os

def tranverse(cur):
    ret = []
    files = os.listdir(cur)
    for i in files:
        name = os.path.join(cur, i)
        if os.path.isdir(name):
            ret.append(name)#compress file directory
            n = tranverse(name)
            ret += n
        elif name[-4:] == '.lua':
            ret.append(name)
    return ret
old = os.getcwd()
print old
os.chdir('Resources')
allLuaFile = tranverse('.')
print allLuaFile

zipFile = zipfile.ZipFile('test.zip', 'w')
for i in allLuaFile:
    zipFile.write(i)
zipFile.commet = "test zip"
zipFile.close()


m = hashlib.md5()
f = open('test.zip').read()
m.update(f)
nf = open('version', 'w')
nf.write(m.hexdigest())
nf.close()


os.system('mv test.zip ../')
os.system('mv version ../')

"""
for i in allLuaFile:
    os.system('luac -o %s.luac %s' % (i, i))
""" 

os.chdir('..')
#os.system('cp test.zip /cygdrive/z/code')
#os.system('cp version /cygdrive/z/code')

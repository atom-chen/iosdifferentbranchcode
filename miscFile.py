#coding:utf8
#处理所有的图片文件 和 音效文件 头几个字节加入随机的字节 
#在cocos2d 中处理文件的时候 文件名称存在文件的头部
#有一个2进制lua文件可以得到所有的 怎么找到对应的文件 来处理呢？
#加密混淆文件
#第一步简单的zip打包
#第二步混淆资源文件
#只做android 平台上面的
#随便混淆一下就好啦

import os
import base64
import time
now = time.strftime("%Y-%m-%d-%H-%M-%S", time.localtime())

os.system('cp -r Resources Resources-%s' % ('old'))
def tranverse(cur):
    ret = []
    files = os.listdir(cur)
    for i in files:
        name = os.path.join(cur, i)
        if os.path.isdir(name):
            #ret.append(name)#compress file directory
            n = tranverse(name)
            ret += n
        #不包含图标文件
        #elif name[-4:] == '.png' or name[-4:] == ".mp3" or name[-4:] == ".ccz" and name.find('Icon') != 0:
        #elif name.find(".plist")==-1:
        else:
            ret.append(name)
    return ret
allFile = tranverse('./Resources/')
#确保每个文件大于200字节
#替换所有的文件即可
prefix = chr(255)+chr(5)+chr(14)+chr(3)+chr(15)+chr(4)+chr(9)+chr(14)+chr(7)+chr(255)
for i in allFile:
    if i.find("main.lua")!=-1 or i.find(".mp3")!=-1:
        continue
    f = open(i, 'rb')
    total = f.read()    
    f.close()
    #如果文件大小为0个字节则不加密处理
    if len(total) == 0:
        continue
    allChr = [prefix]
    head = ord(total[0])
    allChr.append(total[0])
    l = len(total)
    for j in range(1, l):
        allChr.append(chr(ord(total[j]) ^ head))
        head = (head+1)%256
    total = "".join(allChr)

    
    """
    直接替换图片 接着看一下 windows 是否可以运行
    newPlace = ".\\encode"+i[1:]
    lastPart = newPlace.rfind('\\')
    dire = newPlace[:lastPart]
    if not os.path.exists(dire):
        os.makedirs(dire)
    """
    newPlace = i
    nf = open(newPlace, 'wb')
    nf.write(total)
    nf.close()


#test decode
#200 个编码长度是 268 
#解码268 反向得到 200个编码长度
#测试一下图片解码
"""
for i in allPngFile:
    #en = ".\\encode"+i[1:]
    en = i
    f = open(en, 'rb')
    total = f.read()
    f.close()
    head = total[:268]
    tail = total[268:]
    head = base64.b64decode(head)
    total = head+tail
    #.\\ new file 
    i = ".\\decode"+i[1:]
    lastPart = i.rfind('\\')
    
    dire = i[:lastPart]
    if not os.path.exists(dire):
        os.makedirs(dire)

    nf = open(i, 'wb')
    nf.write(total)
    nf.close()
"""

#after compile recover code
#os.system('mv Resources Resources-enc-%s' % (now))
#os.system('mv Resources-%s Resources' % (now))

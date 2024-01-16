from random import randint
from random import choice
list=list(range(0,10))
a=choice(list)
b=choice(list)
c=choice(list)
d=choice(list)
num=0
my_tickect=[2,3,0,8]
while(1):
    num+=1
    a=choice(list)
    b=choice(list)
    c=choice(list)
    d=choice(list)
    print(f"本期的彩票中将号码是{a},{b},{c},{d}")
    if a==my_tickect[0] and b==my_tickect[1] and c==my_tickect[2] and d==my_tickect[3]:
        print(f"你中大奖了,在之前,已经开奖{num}次了")
        break
    else:
        print("您未中奖,请再接再励")


print("测试新增")

                
        新增测试
>>>>>>> cfd1fc1d29982639c2145f1533afcebc309a2d03

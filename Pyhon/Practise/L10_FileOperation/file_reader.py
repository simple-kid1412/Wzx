from pathlib import Path #path是一个类
path=Path('D:\Desktop\Wzx\Pyhon\Practise\L10_FileOperation\pi_digits.txt')
content=path.read_text()
print(content)


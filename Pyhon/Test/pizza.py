class Restaurant:
    def __init__(self,restaurant_name,cuisine_type):
        self.restaurant_name=restaurant_name
        self.cuisine_type=cuisine_type
    def describe_resaurant(self):
        print("our resautant is best")
    def open_resautant(self):
        print("can guan zhengzai yingye ")

shuyuan=Restaurant('beijingshuyuan','chuancai')
shuyuan.describe_resaurant()
shuyuan.open_resautant()


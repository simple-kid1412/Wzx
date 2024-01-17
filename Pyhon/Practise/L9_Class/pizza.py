class Car:
    def __init__(self, make, model, year):
        self.make = make
        self.model = model
        self.year = year
        self.odometer_reading = 0
    def get_descriptive_name(self):
        #描述汽车基本属性
        long_name = f"{self.year} {self.make} {self.model}"
        return long_name.title()
    def read_odometer(self):
        #打印里程数
        print(f"This car has {self.odometer_reading} miles on it.")
    def update_odometer(self, mileage):
        #设置里程数
        if mileage >= self.odometer_reading:
            self.odometer_reading = mileage
        else:
            print("You can't roll back an odometer!")
    def increment_odometer(self, miles):
        #让里程数增加指定的数值
        self.odometer_reading += miles


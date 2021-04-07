from peewee import *
import datetime

from playhouse.mysql_ext import MySQLConnectorDatabase

db = MySQLDatabase(database='bakery', user='root', password='withallah',
                   host='localhost', port=3306)

class daily_sales(Model):
    category=CharField(unique=True)
    quantity=CharField()
    price=IntegerField()
    class Meta:
        database=db

class khama(Model):
    khama_name=CharField(unique=True)
    khama_quantity_in_gm=IntegerField()
    class Meta:
        database=db
class category(Model):
    category_name=CharField(unique=True)
    one_piece_price=IntegerField()
    class Meta:
        database=db
class daily_khama_report(Model):
    name=CharField(unique=True)
    out_quantity=IntegerField()
    available_quantity=IntegerField()
    class Meta:
        database=db


db.connect()
db.create_tables([daily_sales,khama,category,daily_khama_report])
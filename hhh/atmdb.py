from peewee import *
import datetime

from playhouse.mysql_ext import MySQLConnectorDatabase
db = MySQLDatabase(database='atm', user='root', password='withallah',
                   host='localhost', port=3306)

class client_data(Model):
    card_number=CharField(unique=True)
    mail=CharField(unique=True)
    password=CharField()
    money=IntegerField()
    class Meta:
        database=db
class client_access(Model):
    card_number=CharField(unique=True)
    operation=CharField() # money in or money out
    operation_value=IntegerField()
    client_current_money=IntegerField()
    class Meta:
        database=db



class atm_data(Model):
    two_hund_pound=IntegerField()
    one_hund_pound=IntegerField()
    fifty_pound=IntegerField()
    twenty_pound=IntegerField()
    ten_pound=IntegerField()
    five_pound=IntegerField()
    class Meta:
        database=db



db.connect()
db.create_tables([client_data,client_access,atm_data])



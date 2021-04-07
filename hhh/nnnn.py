from PyQt5.QtGui import *
from PyQt5.QtCore import *
from PyQt5.QtWidgets import *
import sys
from xlsxwriter import *
from PyQt5.uic import loadUiType
from datetime import date
from datetime import timedelta
import decimal
import pymysql
pymysql.install_as_MySQLdb()
import os
from os import path


ui,_ = loadUiType('main.ui')

class MainApp(QMainWindow , ui):
    def __init__(self , parent=None):
        super(MainApp , self).__init__(parent)
        QMainWindow.__init__(self)
        self.setupUi(self)
        self.DB_Connection()
        self.UI_Changes()
        self.Handel_buttons()
        self.show_all_categories()
        self.show_khamas()
        self.show_all_daily_sales()
        self.delete_last_data()
        self.daily_khama_report()
        self.show_report()



    def Handel_buttons(self):
        self.pushButton_5.clicked.connect(self.add_category)
        self.pushButton_6.clicked.connect(self.add_khama)
        self.pushButton_2.clicked.connect(self.update_khamas)
        self.pushButton_7.clicked.connect(self.search_for_update)
        self.pushButton.clicked.connect(self.add_daily_sales)
        self.pushButton_9.clicked.connect(self.fill_data_category)
        self.pushButton_3.clicked.connect(self.Export_Report)
    def UI_Changes(self):
        #to handel all ui changes at starting of the program
        pass
    def DB_Connection(self):
        #handelling database connection
        self.db=pymysql.connect(
            host='localhost',
            user='root',
            password='withallah',
            db='bakery'
        )
        self.cur=self.db.cursor()

    def add_category(self):
        category_name=self.lineEdit_2.text()
        price=self.lineEdit_5.text()
        self.cur.execute('''
        insert into category(category_name ,one_piece_price)
        values(%s,%s);
        ''',(category_name,price))
        self.db.commit()
        # now we want to create a new table in the database with the new category name
        self.cur.execute('''
        create table %s (khama_name char(50),quantity_for_one_piece int)
        '''%(category_name,))
        self.cur.fetchall()
        self.db.commit()
        self.show_all_categories()
    def show_all_categories(self):
        self.comboBox_2.clear()
        self.comboBox.clear()
        self.comboBox_7.clear()

        self.cur.execute('''
        select category_name from category ;
        ''')
        data=self.cur.fetchall()

        for category in data:

            self.comboBox_2.addItem(category[0])
            self.comboBox.addItem(category[0])
            self.comboBox_7.addItem(category[0])

    def add_khama(self):
        khama_name = self.lineEdit_3.text()
        quantity = self.lineEdit_4.text()
        self.cur.execute('''
                insert into khama(khama_name ,khama_quantity_in_gm)
                values(%s,%s);
                ''', (khama_name, quantity))
        self.db.commit()
        self.show_khamas()

    def show_khamas(self):
        self.comboBox_3.clear()
        self.comboBox_4.clear()
        self.comboBox_5.clear()
        self.comboBox_6.clear()

        self.cur.execute('''
                select khama_name from khama ;
                ''')
        data = self.cur.fetchall()

        for kh in data:
            self.comboBox_3.addItem(kh[0])
            self.comboBox_4.addItem(kh[0])
            self.comboBox_5.addItem(kh[0])
            self.comboBox_6.addItem(kh[0])


    def search_for_update(self):
        khama_name = self.comboBox_4.currentText()
        self.cur.execute('''
        select khama_quantity_in_gm from khama where khama_name=%s;
        ''',(khama_name,))
        data=self.cur.fetchone()
        for x in data:
            self.lineEdit_6.setText(str(x))


    def update_khamas(self):
        q=str(eval(self.lineEdit_6.text()))

        #q=self.lineEdit_6.text()
        name=self.comboBox_4.currentText()
        self.cur.execute('''
        update khama set khama_quantity_in_gm=%s where khama_name=%s;
        ''',(q,name))
        self.db.commit()

    def add_daily_sales(self):
        today_date = date.today()
        category_name=self.comboBox.currentText()
        quantity_saled=float(self.lineEdit.text())
        self.cur.execute('''
        select one_piece_price from category where category_name=%s;
        ''',(category_name,))
        price=float(self.cur.fetchone()[0]) * quantity_saled
        self.cur.execute('''
        insert into daily_sales(category,quantity,price,today_date)
        values(%s,%s,%s,%s);
        ''',(category_name,quantity_saled,price,today_date))
        self.db.commit()
        self.show_all_daily_sales()

        self.cur.execute('''
                        select khama_name ,quantity_for_one_piece from %s;
                        ''' % (category_name))
        data = self.cur.fetchall()
        for x in data:
            self.cur.execute('''
            select khama_quantity_in_gm from khama where khama_name=%s;
            ''',(x[0],))
            q=self.cur.fetchone()[0]
            self.cur.execute('''
            insert into daily_khama_report(name,out_quantity,available_quantity)
            values(%s,%s,%s)
            ''',(x[0],x[1]*quantity_saled,q-x[1]*quantity_saled))
            self.db.commit()
            self.cur.execute('''
            update khama set khama_quantity_in_gm =%s where khama_name=%s;
            ''',(q-x[1]*quantity_saled,x[0]))
            self.db.commit()
        self.show_report()

    def show_all_daily_sales(self):
        today_date = date.today()
        self.tableWidget.setRowCount(0)
        self.tableWidget.insertRow(0)
        self.cur.execute('''
        select category,quantity,price from daily_sales where today_date=%s ;
        ''',(today_date,))
        data=self.cur.fetchall()
        for row, form in enumerate(data):
            for col, item in enumerate(form):
                self.tableWidget.setItem(row, col, QTableWidgetItem(str(item)))
                col += 1
            row_position = self.tableWidget.rowCount()
            self.tableWidget.insertRow(row_position)
    def show_report(self):
        self.tableWidget_2.setRowCount(0)
        self.tableWidget_2.insertRow(0)
        self.cur.execute('''
                select name,out_quantity,available_quantity from daily_khama_report;
                ''')
        data = self.cur.fetchall()
        for row, form in enumerate(data):
            for col, item in enumerate(form):
                self.tableWidget_2.setItem(row, col, QTableWidgetItem(str(item)))
                col += 1
            row_position = self.tableWidget_2.rowCount()
            self.tableWidget_2.insertRow(row_position)
    def Export_Report(self):
        self.cur.execute('''
        select khama_name from khama;
        ''')
        data=self.cur.fetchall()
        for x in data:
            n=x[0]
            print(n)
            self.cur.execute('''
            SELECT min(available_quantity) from daily_khama_report where name=%s;

            ''',(x[0],))
            a=self.cur.fetchall()
            total=a[0][0]

            print(total)
            self.cur.execute('''
            select sum(out_quantity) from daily_khama_report where name=%s;
            ''',(x[0],))
            o=self.cur.fetchall()

            out=o[0][0]

            print(out)
            self.cur.execute('''
            insert into total(name,total_available,modulous)
            values(%s,%s,%s);
            ''',(n,total,out))

            self.db.commit()

        self.cur.execute(''' 
                SELECT name,total_available,modulous FROM total; 
                ''')

        selection = self.cur.fetchall()
        today_date = date.today()

        excel_file=Workbook('khama exportation'+str(today_date)+'.xlsx')
        sheet1=excel_file.add_worksheet()
        sheet1.write(0,0,'khama name')
        sheet1.write(0,1,'available value')
        sheet1.write(0,2,'today out value')

        row_number=1
        for row in selection:
            column_number=0
            for item in row:
                sheet1.write(row_number,column_number,str(item))
                column_number+=1
            row_number+=1
        excel_file.close()
        self.statusBar().showMessage('khama data exported')
        self.cur.execute('''
        delete from total where name is not null;
        ''')
        self.db.commit()

    def delete_last_data(self):
        today_date = date.today()
        self.cur.execute('''
        delete from daily_sales where today_date != %s;
        ''',(today_date,))
        self.db.commit()

    def fill_data_category(self):
        category_name=self.comboBox_7.currentText()
        khama_name=self.comboBox_6.currentText()
        quantity=int(self.lineEdit_7.text())
        self.cur.execute('''
        insert into %s'''%(category_name)+''' (khama_name,quantity_for_one_piece)
        values(%s,%s);
        ''',(khama_name,quantity))

        self.db.commit()

    def daily_khama_report(self):
        pass




def main():
    app = QApplication(sys.argv)
    window = MainApp()
    window.show()
    app.exec_()
if __name__ == '__main__':
    main()

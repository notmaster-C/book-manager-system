import os
from dotenv import load_dotenv
from mysql.connector import Error
import mysql.connector
import csv
 


def get_db_connection():
    load_dotenv()

    mydb = mysql.connector.connect(
    host="101.42.251.172",
    port="3306",
    user="",
    password="",
    database="sq_book"
    )


    try:
        if mydb.is_connected():
            cursor = mydb.cursor()

    #    cursor.execute("show databases")
        cursor.execute("SELECT * FROM asq_books ")

        col_result = cursor.description

        result = cursor.fetchall()


#        columns=[]
#        for i in range(0,len(col_result)):
#            columns.append(col_result[i][0])

#        return result,columns
        return result

    except Error as e:
        print("Error while connecting to MySQL", e)

    finally:
        mydb.close()


def write_list_to_file(filename):

    data=get_db_connection()

    with open(filename, 'w',newline='',encoding='utf-8') as f:
        write=csv.writer(f,dialect='excel')
        write.writerows([['作者姓名']+['书名']+['类型']+['链接']])

        for item in data:
            write.writerow('')
            write.writerows([item[1:4]])
            write.writerow(['http://101.42.251.172/cms/main/cmsDetail?pptUrl='+str(item[0])])
            write.writerow('')
write_list_to_file('dbinfo\\books.csv')








#print(len(row))
#print(list[0][2])

#lst=List_c(5,5)
#print(lst)
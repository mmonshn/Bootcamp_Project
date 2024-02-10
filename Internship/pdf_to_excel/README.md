#  Time attendance PDF extract to Excel

เป็นโปรแกรมที่เขียนด้วยภาษา Python ในการแปลงไฟล์ PDF เป็นไฟล์ Excel(`.xlsx`) โดยใช้การใส่ไฟล์หรือโฟลเดอร์เข้าไปใน Path ที่กำหนดในไฟล์ `.env`  

## ขั้นตอนการติดตั้ง

    pip install tabula-py
    
    pip install pandas
    
    pip install openpyxl

## วิธีการรัน

 1. นำไฟล์หรือโฟลเดอร์ไปใส่ไว้ใน Path ที่กำหนดในไฟล์ `.env` 
 2. เปิด Command หรือ Terminal จากนั้นเปลี่ยน Directory ไปยังโฟลเดอร์ที่เก็บไฟล์ `app.py`
>
    cd path/to/the/app.py
    python app.py
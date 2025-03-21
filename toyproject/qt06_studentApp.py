# Oracle Student 앱
# CRUD 데이터베이스 DML(SELECT, INSERT, UPDATE, DELETE)
## Create(INSERT), Request(SELECT), Update(UPDATE), Delete(DELETE)
import sys
from PyQt5.QtWidgets import *
from PyQt5.QtGui import *
from PyQt5 import QtWidgets, QtGui, uic

# Oracle 모듈
import cx_Oracle as oci

# DB 연결 설정
sid = 'XE'
host = 'localhost'
port = 1522
username = 'madang'
password = 'madang'

class MainWindow(QMainWindow):
    def __init__(self):
        super(MainWindow, self).__init__()
        self.initUI()
        self.loadData()

    def initUI(self):
        uic.loadUi('./toyproject/studentdb.ui', self)
        self.setWindowTitle('학생정보앱')
        self.setWindowIcon(QIcon('./image/database.png'))

        # 버튼 이벤트 추가
        self.btn_add.clicked.connect(self.btnAddClick)
        self.btn_mod.clicked.connect(self.btnModClick)
        self.btn_del.clicked.connect(self.btnDelClick)
        self.show()

    def btnAddClick(self):
        #print('추가 버튼 클릭')
        std_name = self.input_std_name.text()
        std_mobile = self.input_std_mobile.text()
        std_regyear = self.input_std_regyear.text()
        print(std_name, std_mobile, std_regyear)

        # 입력검증 필수(validation check)
        if std_name == '' or std_regyear == '':
            QMessageBox.warning(self,'경고', '학생이름 또는 학생이름 또는  입력년도 필수')
            return  # 함수 탈출'
        else:
            print('DB 입력 진행')
            values = (std_name, std_mobile, std_regyear)
            self.addData(values)

    def btnModClick(self):
        print('수정 버튼 클릭')

    def btnDelClick(self):
        print('삭제 버튼 클릭')


    def makeTable(self,lst_student):
        self.tblStudent.setColumnCount(4)
        self.tblStudent.setRowCount(len(lst_student)) # 커서에 들어있는 데이터 길이만큼 row 생성
        self.tblStudent.setHorizontalHeaderLabels(['학생번호','학생이름','핸드폰','입학년도'])

        # 전달받은 cursor를 반복문으로 테이블 위젯에 뿌리는 작업 필요
        for i,(std_id, std_name, std_mobile, std_regyear) in enumerate(lst_student):
            self.tblStudent.setItem(i,0,QTableWidgetItem(str(std_id))) # Oracle number 타입은 뿌릴 때 srt()로 형변환 필요!
            self.tblStudent.setItem(i,1,QTableWidgetItem(std_name))
            self.tblStudent.setItem(i,2,QTableWidgetItem(std_mobile))
            self.tblStudent.setItem(i,3,QTableWidgetItem(str(std_regyear)))

    # R(SELECT)
    def loadData(self):
        # db연결
        conn = oci.connect(f'{username}/{password}@{host}:{port}/{sid}')
        cursor = conn.cursor()

        query = ''' select std_id, std_name,
                    std_mobile, std_regyear
                    from students
                '''
        cursor.execute(query)

        lst_student = [] # 리스트 생성
        for _, item in enumerate(cursor):
            lst_student.append(item)

        self.makeTable(lst_student) # 새로 생성한 리스트를 파라미터로 전달달

        cursor.close()
        conn.close()
    
    # C(INSERT)
    def addData(self,tuples):
        conn = oci.connect(f'{username}/{password}@{host}:{port}/{sid}')
        cursor = conn.cursor()

        try:
            conn.begin() # 트랜잭션 시작
            # 쿼리 작성
            query = '''
                    INSERT INTO MADANG.STUDENTS (std_id, std_name, std_mobile, std_regyear)
                    VALUES(SEQ_STUDENT.NEXTVAL, :v_std_name, :v_std_mobile, :v_std_regyear)
                    '''
            cursor.execute(query, tuples) # query에 들어가는 동적변수 3개는 뒤의 tuples에 순서대로 매핑
            
            conn.commit() # DB connit 동일 기능 (트랜잭션 커밋)
            last_id = cursor.lastrowid # SEQ_STUDENT.CURRVAL
            print(last_id)
        except Exception as e:
            print(e)
            conn.rollback() # DB rollback 동일기능
        finally:
            cursor.close()
            conn.close()

if __name__ == '__main__':
    app = QApplication(sys.argv)
    win = MainWindow()
    app.exec_()

    
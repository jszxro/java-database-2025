## PyQt5 첫 윈도우앱 개발
import sys 
from PyQt5.QtWidgets import *
from PyQt5.QtGui import *

class DevWindow(QMainWindow): 
    def __init__(self): 
        super().__init__() 
        self.initUI() # 화면 초기화는 분리

    def initUI(self): # 화면 디자인
        self.setWindowTitle('My First App') # 윈도우 타이틀 지정
        self.setWindowIcon(QIcon('./image/kitty.png')) # 윈도우 아이콘 지정
        self.resize(600,350) # 윈도우 크기 지정

        # 라벨(레이블) 추가
        self.lbl1 = QLabel('버튼 클릭', self)
        self.lbl1.move(10,10) # 위젯 위치 조정
        self.lbl1.resize(130,30) # 사이즈 조정


        # 버튼 추가
        self.btn1 = QPushButton('Click', self)
        self.btn1.clicked.connect(self.btn1click) # 버튼 클릭 시그널(이벤트)함수 연결
        
        self.hbox = QHBoxLayout() # 가로로 구성하는 레이아웃
        self.hbox.addStretch(1) # 여유 공백
        self.hbox.addWidget(self.lbl1)
        self.hbox.addWidget(self.btn1)
        self.hbox.addStretch(1)

        self.vbox = QVBoxLayout() # 세로로 구성하는 레이아웃

        self.setLayout(self.hbox) # 윈도우에 레이아웃 추가

        # 윈도우 바탕화면 정중앙 위치
        qr = self.frameGeometry()
        cp = QDesktopWidget().availableGeometry().center()
        qr.moveCenter(cp)
        self.move(qr.topLeft())

        self.show()

    def btn1click(self):
        # self.lbl1.setText('버튼을 클릭하였습니다')
        QMessageBox.show(self, '알림', '버튼을 클릭하였습니다.')

if __name__ == '__main__': # 메인 모듈
    app = QApplication(sys.argv)    
    win = DevWindow() 
    app.exec() 


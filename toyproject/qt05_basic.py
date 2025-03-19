# QtDesginer 연동 앱
import sys 
from PyQt5.QtWidgets import *
from PyQt5.QtGui import *
from PyQt5 import QtGui, QtWidgets, uic

class DevWindow(QMainWindow): 
    def __init__(self): 
        super(DevWindow,self).__init__() 
        self.initUI()
        
    def initUI(self):
        # QtDesigner 생성 ui 파일 로드
        uic.loadUi('./toyproject/sampleqt.ui', self) # self -> 현재 있는 파일에 연결
        # ui에 있는 위젯에 접근하려면 이름 그대로 사용해야함
        self.lbl1.setText('UI를 로드했습니다')
        self.btn1.clicked.connect(self.btn1click)
        self.btn2.clicked.connect(self.btn2click)
        

        self.show()

    def btn1click(self):
        # self.lbl1.setText('버튼을 클릭하였습니다')
        QMessageBox.show(self, '알림', '버튼을 클릭하였습니다.')

    def btn2click(self):
        ans = QMessageBox.question(self, '종료','종료하시겠습니까?', QMessageBox.Yes | QMessageBox.No, QMessageBox.No)
        if ans == QMessageBox.Yes:
            super().close() # 프로그램 종료

    def closeEvent(self, a0):
        ans = QMessageBox.question(self, '종료','종료하시겠습니까?', QMessageBox.Yes | QMessageBox.No, QMessageBox.No)
        if ans == QMessageBox.Yes:
            e.accept()
        else:
            e.ignore()

if __name__ == '__main__': # 메인 모듈
    app = QApplication(sys.argv)    
    win = DevWindow() 
    app.exec() 
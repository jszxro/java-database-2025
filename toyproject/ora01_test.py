# Oracle 콘솔 연동 예제

import cx_Oracle as oci

# DB 연결 설정 변수 선언
sid = 'XE'
host = '127.0.0.1' # localhost와 동일
port = 1522
username = 'madang'
password = 'madang'

# DB 연결
conn = oci.connect(f'{username}/{password}@{host}:{port}/{sid}')
cursor = conn.cursor() # DB 커서와 동일한 역할을 하는 개체

query = 'SELECT * FROM Students' # 파이썬에서 쿼리 호출 시 ; 삭제
cursor.execute(query)

# 불러온 데이터 처리
for i, item in enumerate(cursor, start=1):
    print(item)

# DB는 연결하면 마지막 close(), 파일은 오픈하면 마지막 닫아줘야 함
cursor.close()
conn.close()

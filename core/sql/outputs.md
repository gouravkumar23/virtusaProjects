SQL*Plus: Release 11.2.0.2.0 Production on Mon Apr 6 17:14:22 2026

Copyright (c) 1982, 2014, Oracle.  All rights reserved.

SQL> connect sys as sysdba
Enter password:
Connected.
SQL> ALTER USER hr IDENTIFIED BY hr ACCOUNT UNLOCK;

User altered.

SQL> connect hr/hr
Connected.
SQL> CREATE TABLE Books (
  2      book_id NUMBER PRIMARY KEY,
  3      title VARCHAR2(100),
  4      category VARCHAR2(50)
  5  );

Table created.

SQL> CREATE TABLE Students (
  2      student_id NUMBER PRIMARY KEY,
  3      name VARCHAR2(100),
  4      last_active DATE
  5  );

Table created.

SQL> CREATE TABLE IssuedBooks (
  2      issue_id NUMBER PRIMARY KEY,
  3      book_id NUMBER,
  4      student_id NUMBER,
  5      issue_date DATE,
  6      return_date DATE,
  7      FOREIGN KEY (book_id) REFERENCES Books(book_id),
  8      FOREIGN KEY (student_id) REFERENCES Students(student_id)
  9  );

Table created.

SQL> INSERT INTO Books VALUES (1, 'Java Basics', 'Education');

1 row created.

SQL> INSERT INTO Books VALUES (2, 'Python Guide', 'Education');

1 row created.

SQL> INSERT INTO Books VALUES (3, 'World History', 'History');

1 row created.

SQL>
SQL> INSERT INTO Students VALUES (101, 'Ravi', SYSDATE - 10);

1 row created.

SQL> INSERT INTO Students VALUES (102, 'Anita', SYSDATE - 1200);

1 row created.

SQL> INSERT INTO Students VALUES (103, 'Kiran', SYSDATE - 5);

1 row created.

SQL>
SQL> INSERT INTO IssuedBooks VALUES (1, 1, 101, SYSDATE - 20, NULL);

1 row created.

SQL> INSERT INTO IssuedBooks VALUES (2, 2, 103, SYSDATE - 5, NULL);

1 row created.

SQL> INSERT INTO IssuedBooks VALUES (3, 3, 102, SYSDATE - 30, SYSDATE - 10);

1 row created.

SQL>
SQL> COMMIT;

Commit complete.

SQL> SELECT s.name, b.title, i.issue_date
  2  FROM IssuedBooks i
  3  JOIN Students s ON i.student_id = s.student_id
  4  JOIN Books b ON i.book_id = b.book_id
  5  WHERE i.return_date IS NULL
  6  AND i.issue_date < SYSDATE - 14;

NAME
--------------------------------------------------------------------------------
TITLE
--------------------------------------------------------------------------------
ISSUE_DAT
---------
Ravi
Java Basics
17-MAR-26


SQL> SELECT b.category, COUNT(*) AS total_borrows
  2  FROM IssuedBooks i
  3  JOIN Books b ON i.book_id = b.book_id
  4  GROUP BY b.category
  5  ORDER BY total_borrows DESC;

CATEGORY                                           TOTAL_BORROWS
-------------------------------------------------- -------------
Education                                                      2
History                                                        1

SQL> DELETE FROM Students
  2  WHERE last_active < SYSDATE - (365 * 3);
DELETE FROM Students
*
ERROR at line 1:
ORA-02292: integrity constraint (HR.SYS_C007077) violated - child record found


SQL> #resolving error
SP2-0734: unknown command beginning "resolving ..." - rest of line ignored.
SQL> DELETE FROM IssuedBooks
  2  WHERE student_id IN (
  3      SELECT student_id
  4      FROM Students
  5      WHERE last_active < SYSDATE - (365 * 3)
  6  );

1 row deleted.

SQL> DELETE FROM Students
  2  WHERE last_active < SYSDATE - (365 * 3);

1 row deleted.

SQL> SELECT * FROM Students;

STUDENT_ID
----------
NAME
--------------------------------------------------------------------------------
LAST_ACTI
---------
       101
Ravi
27-MAR-26

       103
Kiran
01-APR-26

STUDENT_ID
----------
NAME
--------------------------------------------------------------------------------
LAST_ACTI
---------


SQL>
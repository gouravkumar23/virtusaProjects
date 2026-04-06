--creating tables
CREATE TABLE Books (
    book_id NUMBER PRIMARY KEY,
    title VARCHAR2(100),
    category VARCHAR2(50)
);
CREATE TABLE Students (
    student_id NUMBER PRIMARY KEY,
    name VARCHAR2(100),
    last_active DATE
);
CREATE TABLE IssuedBooks (
    issue_id NUMBER PRIMARY KEY,
    book_id NUMBER,
    student_id NUMBER,
    issue_date DATE,
    return_date DATE,
    FOREIGN KEY (book_id) REFERENCES Books(book_id),
    FOREIGN KEY (student_id) REFERENCES Students(student_id)
);

--inserting data
INSERT INTO Books VALUES (1, 'Java Basics', 'Education');
INSERT INTO Books VALUES (2, 'Python Guide', 'Education');
INSERT INTO Books VALUES (3, 'World History', 'History');

INSERT INTO Students VALUES (101, 'Ravi', SYSDATE - 10);
INSERT INTO Students VALUES (102, 'Anita', SYSDATE - 1200);
INSERT INTO Students VALUES (103, 'Kiran', SYSDATE - 5);

INSERT INTO IssuedBooks VALUES (1, 1, 101, SYSDATE - 20, NULL);
INSERT INTO IssuedBooks VALUES (2, 2, 103, SYSDATE - 5, NULL);
INSERT INTO IssuedBooks VALUES (3, 3, 102, SYSDATE - 30, SYSDATE - 10);

COMMIT;


--queries
--1. OverDue Books
SELECT s.name, b.title, i.issue_date
FROM IssuedBooks i
JOIN Students s ON i.student_id = s.student_id
JOIN Books b ON i.book_id = b.book_id
WHERE i.return_date IS NULL
AND i.issue_date < SYSDATE - 14;


--2. Most Popular Book Category
SELECT b.category, COUNT(*) AS total_borrows
FROM IssuedBooks i
JOIN Books b ON i.book_id = b.book_id
GROUP BY b.category
ORDER BY total_borrows DESC;

--3. Removing Inactive Students
DELETE FROM Students
WHERE last_active < SYSDATE - (365 * 3);


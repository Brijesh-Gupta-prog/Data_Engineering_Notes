use exercise;

use exercise1;

--1.1
create table students(
   student_id INT PRIMARY KEY,
   first_name VARCHAR(50) NOT NULL,
   last_name VARCHAR(50) NOT NULL,
   email VARCHAR(100) UNIQUE,
   age INT CHECK (age>16 AND age<100),
   enrollment_date DATE DEFAULT CAST(GETDATE() AS DATE)
);

--1.2
create table courses(
 course_id INT PRIMARY KEY,
 course_name VARCHAR(100) NOT NULL,
 instructor VARCHAR(100) NOT NULL,
 credits INT CHECK (credits>1 AND credits<6),
 max_student INT CHECK(max_student>0)
);

--1.3
create table enrollments(
enrollment_id INT PRIMARY KEY,
student_id INT NOT NULL,
course_id INT NOT NULL,
enrollment_date DATE DEFAULT CAST(GETDATE() AS DATE)
CONSTRAINT FK_ENROLLMENT_STUDENT
    FOREIGN KEY(student_id)
	REFERENCES students(student_id)
	ON DELETE CASCADE,

CONSTRAINT FK_ENROLLMENT_COURSE
    FOREIGN KEY(course_id)
	REFERENCES courses(course_id)
	ON DELETE NO ACTION,

CONSTRAINT UNIQUE_STUDENT_COURSE
   UNIQUE(student_id,course_id)
);


--2.1
insert into students (student_id, first_name, last_name, email, age) values
(1, 'Alice', 'Johnson', 'alice.j@university.edu',20),
(2, 'Charlie', 'Brown', 'charlie.b@university.edu',21),
(3, 'Bob', 'Smith', 'bob.smith@university.edu',19),
(4, 'Diana', 'Williams', 'diana.w@university.edu',22);

--2.2
INSERT INTO courses (course_id, course_name, instructor, credits, max_student)
VALUES
(101, 'Introduction to SQL', 'Dr. Smith', 3, 30),
(102, 'Database Design', 'Dr. Jones', 4, 25),
(103, 'Data Engineering', 'Dr. Brown', 3, 20);

--2.3
INSERT INTO enrollments (enrollment_id,student_id,course_id)
VALUES
(1, 1, 101),
(2, 2,101),
(3, 2,102),
(4, 3,103),
(5, 4,101),
(6, 4,102);

--3.1
select * from students where age>=20

--3.2
select * from courses where credits>3 order by credits DESC;

--3.3
select student_id,course_id,enrollment_date from enrollments order by enrollment_date;

--3.4
select * from students where email like '%@university.edu%';

--4.1
update students set age=20 where first_name='Bob';

--4.2
update courses set max_student=35 where course_name='Introduction to SQL';
select * from courses;
select * from students;
select * from enrollments;

--4.3
update students set age=age+1 where age>=21;

--5.1
delete from enrollments where student_id=2;


--5.2
delete from students where student_id=4;

--5.3
alter table students add phone_number VARCHAR(20);

--6.1
ALTER TABLE courses
ADD status VARCHAR(20)
CONSTRAINT DF_courses_status DEFAULT 'active'
CONSTRAINT CK_courses_status CHECK (status IN ('active','inactive','archived'));

--6.2
UPDATE courses
SET status = 'active'
WHERE status IS NULL;

--6.3
ALTER TABLE students
ADD CONSTRAINT chk_email_at
CHECK (CHARINDEX('@', email) > 0);

--7.1

--Use DELETE → when removing specific rows.
--Use TRUNCATE → when clearing the whole table quickly.

--7.2

delete from enrollments;

--7.3

--just use truncate 
TRUNCATE TABLE enrollments

--8.1

CREATE TABLE grades (
    grade_id INT PRIMARY KEY,
    enrollment_id INT NOT NULL,
    score DECIMAL(5,2) CHECK (score >= 0 AND score <= 100),
    letter_grade VARCHAR(2) CHECK (letter_grade IN ('A','B','C','D','F')),
    graded_date DATE DEFAULT CAST(GETDATE() AS DATE),
    CONSTRAINT fk_grades_enrollment FOREIGN KEY (enrollment_id)
        REFERENCES enrollments(enrollment_id)
        ON DELETE CASCADE
);

--8.2

INSERT INTO grades (grade_id, enrollment_id, score, letter_grade)
VALUES
(1, 1, 95, 'A'),  
(2, 2, 88, 'B'),  
(3, 3, 82, 'B'),  
(4, 4, 76, 'C'),  
(5, 5, 91, 'A'),  
(6, 6, 85, 'B');  

--9.1

insert into students (student_id, first_name, last_name, email, age) values
(5, 'Brijesh', 'Gupta', 'alice.j@university.edu',24);

--Violation of UNIQUE KEY constraint 'UQ__students__AB6E6164D79705DF'. Cannot insert duplicate key in object 'dbo.students'. The duplicate key value is (alice.j@university.edu).

--9.2

--The INSERT statement conflicted with the FOREIGN KEY constraint "fk_enrollment_student".

--9.3

delete from courses where course_id=101;

--10.1

drop table grades;

--10.2

drop table enrollments;

--10.3

drop table courses;

--10.4

drop table students;



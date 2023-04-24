-- create database student_management_ex6;
use student_management_ex6;
create table Students (
studentID int primary key check(studentID between 0 and 9999),
studentName varchar(50),
sAge int  check(sAge between 1 and 9999),
sEmail varchar(100)
);
create table Classes (
classID int primary key check(classID between 0 and 9999),
className varchar(50)
);
create table Subjects (
subjectID int primary key check(subjectID between 0 and 9999),
subjectName varchar(50)
);
create table ClassStudent (
studentID int,
classID int,
foreign key (studentID) references Students(studentID),
foreign key (classID) references Classes(classID)
);
create table Marks (
mark int,
subjectID int,
studentID int,
foreign key (subjectID) references Subjects(subjectID),
foreign key (studentID) references Students(studentID)
);
insert into Students values
(1, "Nguyen Quang An", 18, "an@yahoo,com"),
(2, "Nguyen Cong Vinh", 20, "vinh@gmail.com"),
(3, "Nguyen Van Quyen", 19, "quyen"),
(4, "Pham Thanh Binh", 25, "binh@com"),
(5, "Nguyen Van Tai Em", 30, "taiem@sport.vn");
insert into Classes values
(1, "C0706L"),
(2, "C0708G");
insert into ClassStudent values
(1,1),
(2,1),
(3,2),
(4,2),
(5,2);
insert into Subjects values 
(1, "SQL"),
(2, "Java"),
(3, "C"),
(4, "Visual Basic");
insert into Marks values
(8,1,1),
(4,2,1),
(9,1,1),
(7,1,3),
(3,1,4),
(5,2,5),
(8,3,3),
(1,3,5),
(3,2,4);

-- Hiển thị danh sách tất cả các học viên
select * from students;

-- Hiển thị danh sách tất cả các môn học
select * from subjects;

-- Tính điểm trung bình
select s.studentID,s.studentName,s.sage, avg(m.mark) as AVG_Mark
from students s
join marks m on s.studentID = m.studentID
group by s.studentID;

-- Hiển thị môn học nào có học sinh được điểm cao nhất 
select sub.subjectName, m.mark
from subjects sub
join marks m on sub.subjectID = m.subjectID
join students s on s.studentID = m.studentID
where m.mark = (select max(mark) from marks);

-- Đánh số thứ tự của điểm theo chiều giảm
SELECT (@row := @row + 1) AS STT, m.mark as Mark
FROM marks m, (SELECT @row := 0) r
order by m.mark DESC;

-- Thay doi kieu du lieu cua cot SubjectName trong bang Subjects thanh nvarchar(max)
alter table subjects modify column subjectName varchar(255);

-- Cap nhat them dong chu « Day la mon hoc «  vao truoc cac ban ghi tren cot SubjectName trong bang Subjects
update subjects set subjectname = concat("Đây là môn học ",subjectname);

-- Viet Check Constraint de kiem tra do tuoi nhap vao trong bang Student yeu cau Age >15 va Age < 50
alter table Students add constraint sAge check (sAge between 15 and 50);

-- Loại bỏ tất cả quan hệ giữa các bảng 
set foreign_key_checks = 0;
set foreign_key_checks = 1;
-- vô hiệu hóa foreign key --> = 1 thì kích hoạt lại

-- Xoa hoc vien co StudentID la 1
delete from students where studentID = 1;

-- Trong bang Student them mot column Status co kieu du lieu la Bit va co gia tri Default la 1
alter table students add Status bit default(1);

-- Cap nhap gia tri Status trong bang Student thanh 0
update students set status = 0;
CREATE TABLE person (
    person_id varchar2(5) NOT NULL,
    first_name varchar2(35),
    last_name varchar2(35),
    date_of_birth date,
    gender varchar2(10),
    address varchar2(100),
    city varchar2(50),
    state varchar2(2),
    zip_code number(6,0),

    CONSTRAINT per_PK PRIMARY KEY (person_id)
);


CREATE TABLE section (
    subject varchar2(6) NOT NULL,
    class_number number(5,0),
    section number(4,0),
    title varchar2(75),
    credit_hours number(1,0),
    instructor_id number(4,0),
    days varchar2(5),
    start_time varchar2(8),
    end_time varchar2(8),

    CONSTRAINT sec_PK PRIMARY KEY (subject)
);


CREATE TABLE enrollment (
    subject varchar2(4),
    class_number number(4,0),
    section_number number(3,0),
    student_id varchar2(5),
    
    CONSTRAINT enr_PK PRIMARY KEY (subject, class_number, student_id),
    CONSTRAINT sec_enr FOREIGN KEY (subject)
        REFERENCES section(subject),
        
    CONSTRAINT per_enr FOREIGN KEY (student_id)
        REFERENCES person(person_id)        
);

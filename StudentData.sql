-- Updated Haberman to Haberman-McHadden
UPDATE student
    SET last_name = 'Haberman-McHadden'
    WHERE student_id = '10390';


-- Updated test scores
UPDATE student_exam
    SET score = '924'
    WHERE student_id = '46';
    
UPDATE student_exam
    SET score = '1232'
    WHERE student_id = '1850';
    
UPDATE student_exam
    SET score = '1109'
    WHERE student_id = '2844';

-- Deleted student 18949
DELETE FROM activity
    WHERE student_id = '18949';
    
DELETE FROM volunteer_work
    WHERE student_id = '18949';

DELETE FROM student_guardian
    WHERE student_id = '18949';

DELETE FROM student
    WHERE student_id = '18949';


-- Updated end date and end reason
UPDATE school_attend
    SET end_date = '20-DEC-2010'
    WHERE student_id = '1007' AND
          school_id = '12106';
          
UPDATE school_attend
    SET end_reason = 'Transfer'
    WHERE student_id = '1007' AND
          school_id = '12106';
          
-- Inserted a new row for Anthony's new school
INSERT INTO school_attend (student_id, school_id, enroll_date)
    VALUES ('1007','12460','15-JAN-2011');

-- Entered a new guardian record
INSERT INTO guardian (guardian_id, first_name, last_name, 
                      street_addr, city, state, zip, phone)
    VALUES ('22583','Margaret','Yuters', '1382 N. 5th Ave.',
            'Sarasota','FL', '34234','9413411961');

-- Updated student's legal guardian
DELETE FROM student_guardian
    WHERE guardian_id = '9914';

INSERT INTO student_guardian
    VALUES ('8992','22583','Legal Guardian');
    
-- Querying data
SELECT e.name, COUNT(se.exam_id) AS attempt_number,
       AVG(se.score) AS avg_score
    FROM exam e
    INNER JOIN student_exam se 
    ON e.exam_id = se.exam_id
    WHERE se.test_date >= '01-JAN-2006'
    GROUP BY se.exam_id, e.name
    ORDER BY COUNT(se.exam_id) DESC;
    
SELECT s.last_name || ', ' || s.first_name AS full_name,
       COUNT(sa.decision) AS acceptances
    FROM student s
    INNER JOIN school_apply sa
    ON s.student_id = sa.student_id
    WHERE s.grade_level = 8 AND
          sa.decision = 'accepted'
    GROUP BY sa.student_id, s.last_name, s.first_name
    HAVING COUNT(sa.decision) <=2
    ORDER BY COUNT(sa.decision) DESC,
             s.last_name ASC,
             s.first_name ASC;
             
SELECT sc.name, s.last_name, s.first_name
    FROM student s
    INNER JOIN school_attend sa
    ON s.student_id = sa.student_id
    INNER JOIN school sc
    ON sa.school_id = sc.school_id
    WHERE s.end_date >= '01-JAN-2006' AND
          s.end_reason = 'Graduated' AND
          sc.state = 'GA'
    ORDER BY sc.name ASC,
             s.last_name ASC,
             s.first_name ASC;
  
  SELECT s.first_name, s.last_name, vw.description,
       vw.end_date - vw.start_date AS DAYS
    FROM student s
    INNER JOIN volunteer_work vw
    ON s.student_id = vw.student_id
    WHERE s.grade_level = '5' AND
          vw.end_date - vw.start_date >= '30' AND
          vw.end_date - vw.start_date <= '90'
    ORDER BY vw.end_date - vw.start_date DESC;

SELECT s.last_name || ', ' || s.first_name AS student_name,
       g.last_name || ', ' || g.first_name AS guardian_name
    FROM student s
    INNER JOIN student_guardian sg
    ON s.student_id = sg.student_id
    INNER JOIN guardian g
    ON sg.guardian_id = s.guardian_id
    WHERE s.grade_level IS NOT NULL
          AND sg.relation IN
              ('Foster Mother','Foster Father')
          AND s.city != g.city
    ORDER BY s.last_name ASC,
             s.first_name ASC;

SELECT grade_level, last_name, first_name, phone
    FROM student
    WHERE grade_level IS NOT NULL
    ORDER BY grade_level ASC,
             last_name ASC,
             first_name ASC;

SELECT grade_level, COUNT(*) as num_students
    FROM student
    WHERE grade_level IS NOT NULL
    GROUP BY grade_level
    ORDER BY grade_level ASC;

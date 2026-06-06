CREATE DATABASE IF NOT EXISTS student_db;
USE student_db;


CREATE EXTERNAL TABLE students (
    gender STRING,
    race_ethnicity STRING,
    parental_level_of_education STRING,
    lunch STRING,
    test_preparation_course STRING,
    math_score INT,
    reading_score INT,
    writing_score INT
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
STORED AS TEXTFILE
LOCATION '/Data/StudentsPerformance';

select * from students;
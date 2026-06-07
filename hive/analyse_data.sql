CREATE DATABASE IF NOT EXISTS student_db;
USE student_db;


CREATE EXTERNAL TABLE students (
<<<<<<< HEAD
  gender STRING,
  race_ethnicity STRING,
  parental_level_of_education STRING,
  lunch STRING,
  test_preparation_course STRING,
  math_score STRING,
  reading_score STRING,
  writing_score STRING
)
ROW FORMAT SERDE 'org.apache.hadoop.hive.serde2.OpenCSVSerde'
WITH SERDEPROPERTIES (
  "separatorChar" = ",",
  "quoteChar"     = "\"
=======
    gender STRING,
    race_ethnicity STRING,
    parental_level_of_education STRING,
    lunch STRING,
    test_preparation_course STRING,
    math_score INT,
    reading_score INT,
    writing_score INT
>>>>>>> 92bcb35d73d58d883bcd1fee007e8227c2baa186
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
STORED AS TEXTFILE
LOCATION '/Data/StudentsPerformance';

select * from students;
CREATE DATABASE IF NOT EXISTS student_db;
USE student_db;

DROP TABLE IF EXISTS students;

CREATE EXTERNAL TABLE students (
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
)
STORED AS TEXTFILE
LOCATION 'hdfs://namenode:9000/Data'
TBLPROPERTIES ("skip.header.line.count"="1");

-- Test: afficher les données
SELECT * FROM students LIMIT 10;

-- Vérifier si les notes sont bien lues
SELECT 
  math_score,
  reading_score,
  writing_score
FROM students
LIMIT 10;

-- Nombre total
SELECT COUNT(*) AS total_students
FROM students;

-- Moyenne par gender
SELECT 
  gender,
  AVG(CAST(math_score AS INT)) AS avg_math,
  AVG(CAST(reading_score AS INT)) AS avg_reading,
  AVG(CAST(writing_score AS INT)) AS avg_writing
FROM students
GROUP BY gender;

-- Moyenne générale par préparation au test
SELECT
  test_preparation_course,
  AVG(
    (CAST(math_score AS INT) + CAST(reading_score AS INT) + CAST(writing_score AS INT)) / 3
  ) AS avg_general_score
FROM students
GROUP BY test_preparation_course;

-- Moyenne générale par niveau d'éducation des parents
SELECT
  parental_level_of_education,
  AVG(
    (CAST(math_score AS INT) + CAST(reading_score AS INT) + CAST(writing_score AS INT)) / 3
  ) AS avg_general_score
FROM students
GROUP BY parental_level_of_education;

-- Pass / Fail
SELECT
  CASE 
    WHEN (
      (CAST(math_score AS INT) + CAST(reading_score AS INT) + CAST(writing_score AS INT)) / 3
    ) >= 50 THEN 'Pass'
    ELSE 'Fail'
  END AS result,
  COUNT(*) AS total_students
FROM students
GROUP BY 
  CASE 
    WHEN (
      (CAST(math_score AS INT) + CAST(reading_score AS INT) + CAST(writing_score AS INT)) / 3
    ) >= 50 THEN 'Pass'
    ELSE 'Fail'
  END;

-- Max / Min
SELECT
  MAX(CAST(math_score AS INT)) AS max_math,
  MIN(CAST(math_score AS INT)) AS min_math,
  MAX(CAST(reading_score AS INT)) AS max_reading,
  MIN(CAST(reading_score AS INT)) AS min_reading,
  MAX(CAST(writing_score AS INT)) AS max_writing,
  MIN(CAST(writing_score AS INT)) AS min_writing
FROM students;
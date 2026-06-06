from pyspark.sql import SparkSession
from pyspark.sql.functions import avg, col

spark = SparkSession.builder \
    .appName("Students Analysis") \
    .master("spark://spark-master:7077") \
    .getOrCreate()
    
# Read CSV from HDFS
df = spark.read.csv(
    "hdfs://namenode:9000/Data/StudentsPerformance.csv",
    header=True,
    inferSchema=True
)


# Dataset Information
print("\n DATASET INFO ")
print("Number of rows:")
print(df.count())
print("\nSchema:")
df.printSchema()
print("\nFirst 5 rows:")
df.show(5)
print("\nStatistics:")
df.describe().show()

# Male vs Female


print("MALE VS FEMALE")
gender_stats = df.groupBy("gender").agg(
    avg("math score").alias("avg_math"),
    avg("reading score").alias("avg_reading"),
    avg("writing score").alias("avg_writing")
)

gender_stats.show()

# Test Preparation Course

print(" TEST PREPARATION ")
prep_stats = df.groupBy("test preparation course").agg(
    avg("math score").alias("avg_math"),
    avg("reading score").alias("avg_reading"),
    avg("writing score").alias("avg_writing")
)
prep_stats.show()

# Ethnicity analysis


print("\n===== RACE / ETHNICITY ANALYSIS =====")

race_stats = df.groupBy("race/ethnicity").agg(
    avg("math score").alias("avg_math"),
    avg("reading score").alias("avg_reading"),
    avg("writing score").alias("avg_writing")
)

race_stats.show()

# Top 10 Students

print("\n===== TOP 10 STUDENTS =====")
df2 = df.withColumn(
    "total_score",
    col("math score") +
    col("reading score") +
    col("writing score")
)
top10 = df2.orderBy(
    col("total_score").desc()
).limit(10)
top10.show()

# Best ethnic group
print("BEST ETHNIC GROUP ")
best_group = race_stats.orderBy(
    col("avg_math").desc()
)
best_group.show(1)


# The RESULT of each stat will be in the Result folder inside Student_Data  and
# screenshots taked from the Spark-client 

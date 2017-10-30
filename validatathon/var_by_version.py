from pyspark.sql import SparkSession
from pyspark.sql.types import Row

spark = SparkSession.builder.getOrCreate()
sc = spark.sparkContext

merged = spark.read.parquet("s3a://dbb-cn-transfer/2015-10-25/debug/2017-10-27-00-22-26")
merged.createOrReplaceTempView("merged")

spark.sql("SELECT version, variable, count(*) as count FROM merged group by version, variable order by variable") \
        .coalesce(1) \
        .write.csv("var_by_ver", header=True)

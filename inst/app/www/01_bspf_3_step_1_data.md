---
output: 
    html_document:
        css: custom.css
        keep_md: yes
params:
    foo: bar
editor_options: 
  chunk_output_type: console
---

<style type="text/css">
.main-container {
  max-width: 1800px;
  margin-left: auto;
  margin-right: auto;
}
</style>



## Was passiert hier? {#dbt_default .emphasized}

Daten erheben


```
## Rows: 1,250
## Columns: 35
## $ Age                      [3m[90m<dbl>[39m[23m 41, 49, 37, 33, 27, 32, 59, 30, 38, 36, 35, 2…
## $ Attrition                [3m[90m<chr>[39m[23m "Yes", "No", "Yes", "No", "No", "No", "No", "…
## $ BusinessTravel           [3m[90m<chr>[39m[23m "Travel_Rarely", "Travel_Frequently", "Travel…
## $ DailyRate                [3m[90m<dbl>[39m[23m 1102, 279, 1373, 1392, 591, 1005, 1324, 1358,…
## $ Department               [3m[90m<chr>[39m[23m "Sales", "Research & Development", "Research …
## $ DistanceFromHome         [3m[90m<dbl>[39m[23m 1, 8, 2, 3, 2, 2, 3, 24, 23, 27, 16, 15, 26, …
## $ Education                [3m[90m<dbl>[39m[23m 2, 1, 2, 4, 1, 2, 3, 1, 3, 3, 3, 2, 1, 3, 4, …
## $ EducationField           [3m[90m<chr>[39m[23m "Life Sciences", "Life Sciences", "Other", "L…
## $ EmployeeCount            [3m[90m<dbl>[39m[23m 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, …
## $ EmployeeNumber           [3m[90m<dbl>[39m[23m 1, 2, 4, 5, 7, 8, 10, 11, 12, 13, 14, 15, 16,…
## $ EnvironmentSatisfaction  [3m[90m<dbl>[39m[23m 2, 3, 4, 4, 1, 4, 3, 4, 4, 3, 1, 4, 1, 3, 2, …
## $ Gender                   [3m[90m<chr>[39m[23m "Female", "Male", "Male", "Female", "Male", "…
## $ HourlyRate               [3m[90m<dbl>[39m[23m 94, 61, 92, 56, 40, 79, 81, 67, 44, 94, 84, 4…
## $ JobInvolvement           [3m[90m<dbl>[39m[23m 3, 2, 2, 3, 3, 3, 4, 3, 2, 3, 4, 2, 3, 2, 4, …
## $ JobLevel                 [3m[90m<dbl>[39m[23m 2, 2, 1, 1, 1, 1, 1, 1, 3, 2, 1, 2, 1, 1, 3, …
## $ JobRole                  [3m[90m<chr>[39m[23m "Sales Executive", "Research Scientist", "Lab…
## $ JobSatisfaction          [3m[90m<dbl>[39m[23m 4, 2, 3, 3, 2, 4, 1, 3, 3, 3, 2, 3, 3, 3, 1, …
## $ MaritalStatus            [3m[90m<chr>[39m[23m "Single", "Married", "Single", "Married", "Ma…
## $ MonthlyIncome            [3m[90m<dbl>[39m[23m 5993, 5130, 2090, 2909, 3468, 3068, 2670, 269…
## $ MonthlyRate              [3m[90m<dbl>[39m[23m 19479, 24907, 2396, 23159, 16632, 11864, 9964…
## $ NumCompaniesWorked       [3m[90m<dbl>[39m[23m 8, 1, 6, 1, 9, 0, 4, 1, 0, 6, 0, 0, 1, 5, 1, …
## $ Over18                   [3m[90m<chr>[39m[23m "Y", "Y", "Y", "Y", "Y", "Y", "Y", "Y", "Y", …
## $ OverTime                 [3m[90m<chr>[39m[23m "Yes", "No", "Yes", "Yes", "No", "No", "Yes",…
## $ PercentSalaryHike        [3m[90m<dbl>[39m[23m 11, 23, 15, 11, 12, 13, 20, 22, 21, 13, 13, 1…
## $ PerformanceRating        [3m[90m<dbl>[39m[23m 3, 4, 3, 3, 3, 3, 4, 4, 4, 3, 3, 3, 3, 3, 3, …
## $ RelationshipSatisfaction [3m[90m<dbl>[39m[23m 1, 4, 2, 3, 4, 3, 1, 2, 2, 2, 3, 4, 4, 2, 3, …
## $ StandardHours            [3m[90m<dbl>[39m[23m 80, 80, 80, 80, 80, 80, 80, 80, 80, 80, 80, 8…
## $ StockOptionLevel         [3m[90m<dbl>[39m[23m 0, 1, 0, 0, 1, 0, 3, 1, 0, 2, 1, 0, 1, 0, 1, …
## $ TotalWorkingYears        [3m[90m<dbl>[39m[23m 8, 10, 7, 8, 6, 8, 12, 1, 10, 17, 6, 10, 5, 6…
## $ TrainingTimesLastYear    [3m[90m<dbl>[39m[23m 0, 3, 3, 3, 3, 2, 3, 2, 2, 3, 5, 3, 1, 4, 1, …
## $ WorkLifeBalance          [3m[90m<dbl>[39m[23m 1, 3, 3, 3, 3, 2, 2, 3, 3, 2, 3, 3, 2, 3, 3, …
## $ YearsAtCompany           [3m[90m<dbl>[39m[23m 6, 10, 0, 8, 2, 7, 1, 1, 9, 7, 5, 9, 5, 4, 10…
## $ YearsInCurrentRole       [3m[90m<dbl>[39m[23m 4, 7, 0, 7, 2, 7, 0, 0, 7, 7, 4, 5, 2, 2, 9, …
## $ YearsSinceLastPromotion  [3m[90m<dbl>[39m[23m 0, 1, 0, 3, 2, 3, 0, 0, 1, 7, 0, 0, 4, 0, 8, …
## $ YearsWithCurrManager     [3m[90m<dbl>[39m[23m 5, 7, 0, 0, 2, 6, 0, 0, 8, 7, 3, 8, 3, 3, 8, …
```


Table: Data summary

|                         |           |
|:------------------------|:----------|
|Name                     |Piped data |
|Number of rows           |1250       |
|Number of columns        |35         |
|_______________________  |           |
|Column type frequency:   |           |
|character                |9          |
|numeric                  |26         |
|________________________ |           |
|Group variables          |None       |


**Variable type: character**

|skim_variable  | n_missing| complete_rate| min| max| empty| n_unique| whitespace|
|:--------------|---------:|-------------:|---:|---:|-----:|--------:|----------:|
|Attrition      |         0|             1|   2|   3|     0|        2|          0|
|BusinessTravel |         0|             1|  10|  17|     0|        3|          0|
|Department     |         0|             1|   5|  22|     0|        3|          0|
|EducationField |         0|             1|   5|  16|     0|        6|          0|
|Gender         |         0|             1|   4|   6|     0|        2|          0|
|JobRole        |         0|             1|   7|  25|     0|        9|          0|
|MaritalStatus  |         0|             1|   6|   8|     0|        3|          0|
|Over18         |         0|             1|   1|   1|     0|        1|          0|
|OverTime       |         0|             1|   2|   3|     0|        2|          0|


**Variable type: numeric**

|skim_variable            | n_missing| complete_rate|     mean|      sd|   p0|     p25|     p50|      p75|  p100|hist  |
|:------------------------|---------:|-------------:|--------:|-------:|----:|-------:|-------:|--------:|-----:|:-----|
|Age                      |         0|             1|    36.95|    9.08|   18|   30.00|    36.0|    43.00|    60|▂▇▇▃▂ |
|DailyRate                |         0|             1|   799.74|  403.52|  102|  464.00|   798.0|  1156.00|  1498|▇▇▇▇▇ |
|DistanceFromHome         |         0|             1|     9.10|    8.10|    1|    2.00|     7.0|    13.75|    29|▇▅▁▂▂ |
|Education                |         0|             1|     2.91|    1.03|    1|    2.00|     3.0|     4.00|     5|▂▅▇▆▁ |
|EmployeeCount            |         0|             1|     1.00|    0.00|    1|    1.00|     1.0|     1.00|     1|▁▁▇▁▁ |
|EmployeeNumber           |         0|             1|  1022.71|  600.42|    1|  486.25|  1020.5|  1553.75|  2068|▇▇▇▇▇ |
|EnvironmentSatisfaction  |         0|             1|     2.71|    1.09|    1|    2.00|     3.0|     4.00|     4|▅▅▁▇▇ |
|HourlyRate               |         0|             1|    65.82|   20.14|   30|   48.00|    66.0|    83.00|   100|▇▇▇▇▇ |
|JobInvolvement           |         0|             1|     2.75|    0.71|    1|    2.00|     3.0|     3.00|     4|▁▃▁▇▂ |
|JobLevel                 |         0|             1|     2.08|    1.12|    1|    1.00|     2.0|     3.00|     5|▇▇▃▂▁ |
|JobSatisfaction          |         0|             1|     2.73|    1.11|    1|    2.00|     3.0|     4.00|     4|▅▅▁▇▇ |
|MonthlyIncome            |         0|             1|  6569.40| 4777.89| 1009| 2935.25|  4903.5|  8395.00| 19999|▇▅▂▁▂ |
|MonthlyRate              |         0|             1| 14294.50| 7071.61| 2097| 8191.25| 14328.0| 20337.25| 26999|▇▇▇▇▇ |
|NumCompaniesWorked       |         0|             1|     2.71|    2.49|    0|    1.00|     2.0|     4.00|     9|▇▃▂▂▁ |
|PercentSalaryHike        |         0|             1|    15.23|    3.69|   11|   12.00|    14.0|    18.00|    25|▇▅▃▂▁ |
|PerformanceRating        |         0|             1|     3.16|    0.36|    3|    3.00|     3.0|     3.00|     4|▇▁▁▁▂ |
|RelationshipSatisfaction |         0|             1|     2.71|    1.09|    1|    2.00|     3.0|     4.00|     4|▅▆▁▇▇ |
|StandardHours            |         0|             1|    80.00|    0.00|   80|   80.00|    80.0|    80.00|    80|▁▁▇▁▁ |
|StockOptionLevel         |         0|             1|     0.80|    0.86|    0|    0.00|     1.0|     1.00|     3|▇▇▁▂▁ |
|TotalWorkingYears        |         0|             1|    11.40|    7.79|    0|    6.00|    10.0|    15.00|    40|▇▇▃▁▁ |
|TrainingTimesLastYear    |         0|             1|     2.81|    1.29|    0|    2.00|     3.0|     3.00|     6|▂▇▇▂▃ |
|WorkLifeBalance          |         0|             1|     2.76|    0.71|    1|    2.00|     3.0|     3.00|     4|▁▃▁▇▂ |
|YearsAtCompany           |         0|             1|     7.09|    6.21|    0|    3.00|     5.0|    10.00|    40|▇▂▁▁▁ |
|YearsInCurrentRole       |         0|             1|     4.26|    3.66|    0|    2.00|     3.0|     7.00|    18|▇▅▂▁▁ |
|YearsSinceLastPromotion  |         0|             1|     2.21|    3.20|    0|    0.00|     1.0|     3.00|    15|▇▁▁▁▁ |
|YearsWithCurrManager     |         0|             1|     4.16|    3.59|    0|    2.00|     3.0|     7.00|    17|▇▂▅▁▁ |


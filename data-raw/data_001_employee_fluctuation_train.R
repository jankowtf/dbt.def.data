## code to prepare `data_001_employee_fluctuation_train` dataset goes here

usethis::use_data(data_001_employee_fluctuation_train, overwrite = TRUE)

# Only as long as I didn't port the targets workflow from 'dbt-def-lab-001'
if (FALSE) {
    data_001_employee_fluctuation_train <- readRDS("data-static/data_001_employee_fluctuation_train.rds")
    usethis::use_data(data_001_employee_fluctuation_train)
}

# Export to app -----------------------------------------------------------

.tmp <- try(tar_meta(), silent = TRUE)

if (!inherits(.tmp, "try-error") || length(.tmp)) {
    tar_read(path_config_crosswalk) %>%
        fs::file_copy(here::here("inst/app/config_crosswalk.yml"), overwrite = TRUE)

    tar_read(crosswalk_encoding_data_train_files) %>%
        saveRDS(file = here::here("inst/app/crosswalk_encoding_data_train_files.rds"))

    tar_read(data_train) %>%
        saveRDS(file = here::here("inst/app/data_train.rds"))
    tar_read(data_train_de_cols) %>%
        saveRDS(file = here::here("inst/app/data_train_de_cols.rds"))
}

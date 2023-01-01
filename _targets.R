library(targets)

# Set target-specific options such as packages.
tar_option_set(
    # packages = c("dplyr", "dbt.def.lab.001")
    packages = c(
        "dplyr",
        "laker",
        "dbt.def.data"
    ),
    imports = c(
        "dbt.def.data"
    )
)

laker::link_data_lake(
    "~/data/dbt.def.datalake/lab_001",
    "datalake"
)

# Options -----------------------------------------------------------------

storage <- valid::valid_storage("fs")
# storage <- valid::valid_storage("aws_s3")

repository <- switch(storage,
    fs = "local",
    aws = "aws_s3",
    gcp = "gcp_cs"
)

tar_option_set(repository = repository)
# tar_option_get("repository")

# tar_option_set(resources = tar_resources(
#     aws = tar_resources_aws(
#         bucket = "dbt-def-layer-00",
#         region = Sys.getenv("AWS_REGION")
#     ),
#     feather = tar_resources_feather()
# ))

targets::tar_option_get("resources")

# Logging -----------------------------------------------------------------

logger::log_layout(logger::layout_glue_colors)

# Targets -----------------------------------------------------------------

list(
    tar_target(
        path_data_001_employee_fluctuation_train,
        "datalake/layer_00/telco_train.xlsx",
        format = "file"
    ),
    tar_target(
        data_001_employee_fluctuation_train,
        path_data_001_employee_fluctuation_train %>% io_read_xlsx()
    ),
    tar_target(
        path_data_definitions,
        "datalake/layer_00/telco_data_definitions.xlsx",
        format = "file"
    ),
    tar_target(
        data_definitions,
        path_data_definitions %>% io_read_xlsx(col_names = FALSE)
    ),
    tar_target(
        cw_encoding_data_001_employee_fluctuation_train,
        data_001_employee_fluctuation_train %>% cw_encoding_extract()
    ),
    tar_target(
        cw_encoding_data_001_employee_fluctuation_train_files,
        cw_encoding_data_001_employee_fluctuation_train %>% cw_encoding_persist()
    ),
    # # tarchetypes::tar_files(
    # #     test,
    # # crosswalk_encoding_data_001_employee_fluctuation_train_files
    # # ),
    tar_target(
        data_001_employee_fluctuation_train_de_enc,
        data_001_employee_fluctuation_train %>%
            tr_crosswalk_encoding_en_de(
                crosswalk_files = cw_encoding_data_001_employee_fluctuation_train_files,
                vec_cast = FALSE
            )
    ),
    # tar_target(
    #     path_config_crosswalk,
    #     "datalake/layer_01/config_crosswalk.yml",
    #     format = "file"
    # ),
    # tar_target(
    #     data_001_employee_fluctuation_train_de_cols,
    #     data_001_employee_fluctuation_train_de_enc %>% tr_crosswalk_columns_en_de(
    #         path_crosswalk_def = path_config_crosswalk
    #     )
    # ),
    # tar_target(
    #     resource_template_pptx,
    #     "datalake/layer_01/resources/DB_Training_Vorlage_Praesentationen_2019 v2.pptx"
    # )
    # # tar_target(
    # #     rmd_check,
    # #     {
    # #         devtools::load_all()
    # #         paths_rmd <- c(
    # #             "app/www/00_bspf.Rmd",
    # #             "app/www/01_bspf_1_step_1.Rmd",
    # #             "app/www/01_bspf_2_step_3_hypotheses.Rmd",
    # #
    # #             # --- BSPF phase 3
    # #             "app/www/01_bspf_3_step_1_data.Rmd",
    # #             "app/www/01_bspf_3_step_2_kpis.Rmd",
    # #
    # #             # --- BSPF phase 4
    # #             "app/www/01_bspf_4_step_1_probsnopps.Rmd",
    # #
    # #             # --- BSPF phase 4
    # #             "app/www/01_dataunderstanding_step_1_prototyping.Rmd"
    # #         ) %>% app_sys()
    # #
    # #         paths_md <- paths_rmd %>% fs::path_ext_set("md")
    # #
    # #         ensure_markdown_files(paths_rmd = paths_rmd, paths_md = paths_md, force = TRUE)
    # #     }
    # # )
)

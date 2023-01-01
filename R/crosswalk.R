# Encoding ----------------------------------------------------------------

#' Crosswalk: extract encoding
#'
#' @param data [tibble()]
#'
#' @return
#' @export
#'
#' @examples
cw_encoding_extract <- function(data) {
    logger::log_info("Extracting encoding")

    cols <- data %>% names()
    encoding <- cols %>%
        purrr::map(function(.x) {
            data %>% dplyr::count(.data[[.x]], sort = TRUE)
        }) %>%
        purrr::set_names(cols)

    logger::log_success("Encoding extracted")

    encoding
}

#' Crosswalk: expand encoding
#'
#' @param encoding
#' @param overwrite
#'
#' @return
#' @export
#'
#' @examples
cw_encoding_expand <- function(encoding,
                               language = "en",
                               encoding_add = c("de_int", "de_ext"),
                               encoding_prefill = c("NA", "original")) {
    # encoding_prefill <- match.arg(encoding_prefill)
    # encoding_prefill <- if (encoding_prefill == "NA") {
    #     NA
    # } else {
    #     "encoding_int" %>% dplyr::sym()
    # }

    col <- encoding %>%
        names() %>%
        `[`(1)
    col_sym <- col %>% dplyr::sym()

    message(col)

    data <- encoding[[1]]

    data_left <- data %>%
        dplyr::rename(encoding_int = col) %>%
        dplyr::mutate(
            variable = col,
            encoding_ext = encoding_int,
            language = language,
        ) %>%
        dplyr::select(variable, encoding_int, encoding_ext, language, everything())

    # Expand inner
    data_right <- encoding_add %>% purrr::map_dfc(function(.col) {
        .col <- "encoding_" %>%
            stringr::str_c(.col) %>%
            dplyr::sym()

        data %>%
            dplyr::mutate(
                !!.col :=
                    if (!!col_sym %>% inherits("numeric") || encoding_prefill == "original") {
                        !!col_sym
                    } else {
                        NA_character_
                    }
            ) %>%
            dplyr::select(.col)
    })

    dplyr::bind_cols(
        data_left,
        data_right
    )
}

#' Crosswalk: expand encodings
#'
#' Expand encodings
#'
#' @param encodings DESCRIPTION.
#' @param language DESCRIPTION.
#' @param encoding_add DESCRIPTION.
#'
#' @return RETURN_DESCRIPTION
#' @examples
#' # ADD_EXAMPLES_HERE
cw_encodings_expand <- function(encodings,
                                language = "en",
                                encoding_add = c("de_int", "de_ext")) {
    paths <- encodings %>%
        purrr::imap(function(.encoding, .name) {
            .encoding <- list(.encoding) %>% purrr::set_names(.name)
            cw_encoding_expand(
                encoding = .encoding,
                language = language,
                encoding_add = encoding_add
            )
        })
}

# Persist ----------------------------------------------------------------------

#' Crosswalk: persist encoding
#'
#' @param encoding
#' @param overwrite
#'
#' @return
#' @export
#'
#' @examples
cw_encoding_persist <- function(encoding,
                                path_dir = here::here("datalake", "layer_01"),
                                overwrite = FALSE) {
    col_variable <- "variable" %>% dplyr::sym()
    var_name <- encoding %>%
        dplyr::distinct(!!col_variable) %>%
        dplyr::pull()

    col_encoding <- "encoding_int" %>% dplyr::sym()

    # Capture class
    class <- encoding %>%
        dplyr::pull(!!col_encoding) %>%
        class() %>%
        `[`(1)

    # Persist
    path <- here::here(
        path_dir,
        "crosswalk_enc_{class}_{var_name %>% tolower()}" %>%
            stringr::str_glue()
    )
    fs::path_ext(path) <- "csv"

    if (!(path %>% fs::file_exists()) || overwrite) {
        encoding %>% write.csv2(file = path, row.names = FALSE)
        logger::log_success("Persisted encoding crosswalk file to {path}")
    } else {
        logger::log_info("File {path} already exists")
    }

    # Return
    path
}

#' Persist encoding crosswalk files
#'
#' @param encoding
#' @param overwrite
#'
#' @return
#' @export
#'
#' @examples
cw_encodings_persist <- function(encodings,
                                 path_dir = here::here("datalake", "layer_01"),
                                 overwrite = FALSE) {
    encodings %>%
        purrr::map_chr(cw_encoding_persist,
            path_dir = path_dir,
            overwrite = overwrite
        )
}

# Create crosswalk table --------------------------------------------------

# cw_create_table <- function(path = app_sys("app/config_crosswalk.yml")) {
#     crosswalk <- confx::conf_get(from = path)

#     crosswalk %>% purrr::imap_dfr(function(.x, .y) {
#         tibble::tibble(
#             data = .y
#         ) %>%
#             dplyr::bind_cols(
#                 .x %>% cw_create_table_inner()
#             )
#     })
# }

# cw_create_table_inner <- function(x) {
#     x %>% purrr::imap_dfr(function(.x, .y) {
#         tibble::tibble(
#             internal = .y
#         ) %>%
#             dplyr::bind_cols(
#                 .x %>% tibble::as_tibble()
#             )
#     })
# }

# Rename columns ----------------------------------------------------------

#' Crosswalk: encode column
#'
#' @param data [tibble()]
#' @param path_cw_encoding
#' @param vec_cast
#'
#' @return
#' @export
#'
#' @examples
cw_encode_column <- function(data,
                             path_cw_encoding,
                             col = character(),
                             vec_cast = TRUE) {
    cw_encoding <- read.csv2(path_cw_encoding)

    if (!length(col)) {
        col <- names(path_cw_encoding)
    }

    # Early exit
    if (!(col %in% names(data))) {
        return(NULL)
    }

    col_sym <- col %>% dplyr::sym()

    logger::log_info("Trying crosswalk encoding: {col}")

    # Args
    args <- list(
        .data = data,
        var = col_sym,
        cw_file = cw_def,
        raw = as.name("encoding_orig"),
        clean = as.name("encoding_new"),
        label = as.name("encoding_orig")
    )

    # Construct call
    expr <- rlang::call2(
        crosswalkr::encodefrom,
        !!!args
    )

    # Execute encoding crosswalk
    # data_trans <- data %>%
    #     dplyr::select(!!col_sym) %>%
    #     dplyr::mutate(
    #         !!col_sym := expr %>%
    #             rlang::eval_tidy() %>%
    #             vctrs::vec_restore(!!col_sym)
    #     )

    data_trans <- data %>%
        dplyr::select(!!col_sym) %>%
        dplyr::mutate(
            !!col_sym := expr %>%
                rlang::eval_tidy() %>%
                {
                    if (vec_cast) {
                        # vctrs::vec_restore(!!col_sym)
                        vctrs::vec_cast(., !!col_sym %>% vctrs::vec_ptype())
                    } else {
                        .
                    }
                }
        )

    logger::log_success("Crosswalk encoding: {col}")

    data_trans
}

cw_encode_columns <- function(data,
                              crosswalk_files,
                              vec_cast = TRUE) {
    crosswalk_files %>%
        # `[`(1:3) %>%
        purrr::imap_dfc(function(.x, .y) {
            data %>% cw_encode_column(path_cw_encoding = .x, col = .y)
        })
}

#' FUNCTION_TITLE
#'
#' FUNCTION_DESCRIPTION
#'
#' @param data DESCRIPTION.
#' @param crosswalk_table DESCRIPTION.
#' @param from DESCRIPTION.
#' @param to DESCRIPTION.
#'
#' @return RETURN_DESCRIPTION
#' @examples
#' # ADD_EXAMPLES_HERE
cw_rename_columns <- function(data,
                              crosswalk_table,
                              from = "internal",
                              to = "external_en") {
    from_ <- crosswalk_table %>% dplyr::pull(!!from)
    to_ <- crosswalk_table %>% dplyr::pull(!!to)

    # purrr::map(from_, function(.from) {
    #     .from %>% as.list()
    # })

    cols <- from_ %>%
        as.list() %>%
        purrr::set_names(to_)

    cols_current <- data %>% names()
    index <- (cols %>% unlist()) %in% cols_current

    cols <- cols[index]

    data %>% dplyr::rename(!!!cols)
}


#' Crosswalk column names: `en` to `de`
#'
#' @param data
#'
#' @return
#' @export
#'
#' @examples
cw_columns_en_de <- function(data,
                             path_crosswalk_def = app_sys("app/config_crosswalk.yml")) {
    # cols <- list(
    #     Alter = "Age",
    #     Abgang = "Attrition",
    #     Reisen = "BusinessTravel",
    #     DailyRate = "DailyRate", # ?
    #     Abteilung = "Department",
    #     EntfernungWohnort = "DistanceFromHome",
    #     Ausbildung = "Education",
    #     AusbildungBereich = "EducationField",
    #     MitarbeiterZaehler = "EmployeeCount",
    #     MitarbeiterNummer = "EmployeeNumber",
    #     ZufriedenheitUmgebung = "EnvironmentSatisfaction",
    #     Geschlecht = "Gender",
    #     Stundensatz = "HourlyRate",
    #     JobMitarbeit = "JobInvolvement",
    #     JobLevel = "JobLevel",
    #     JobRolle = "JobRole",
    #     JobZufriedenheit = "JobSatisfaction",
    #     Beziehungsstatus = "MaritalStatus",
    #     EinkommenMonat = "MonthlyIncome",
    #     SatzMonat = "MonthlyRate",
    #     AnzahlVorherigeArbeitgeber = "NumCompaniesWorked",
    #     Ueber18 = "Over18",
    #     Ueberstunden = "OverTime",
    #     GehaltserhoehungProzent = "PercentSalaryHike",
    #     Leistungsbeurteilung = "PerformanceRating",
    #     ZufriedenheitBeziehung = "RelationshipSatisfaction",
    #     StandardArbeitszeit = "StandardHours",
    #     Aktienoptionen = "StockOptionLevel",
    #     Berufserfahrung = "TotalWorkingYears",
    #     TrainingszeitenLetztesJahr = "TrainingTimesLastYear",
    #     WorkLifeBalance = "WorkLifeBalance",
    #     FirmenzugehoerigkeitJahre = "YearsAtCompany",
    #     JahreInDerzeitigerPosition = "YearsInCurrentRole",
    #     JahreSeitLetzterBefoerderung = "YearsSinceLastPromotion",
    #     JahreMitDerzeitigemVorgesetzten = "YearsWithCurrManager"
    # )

    logger::log_info("Crosswalking column names: 'en' to 'de")

    # out <- data %>% dplyr::rename(!!!cols)

    out <- data %>% cw_rename_columns(
        crosswalk_table = cw_create_table(
            path = path_crosswalk_def
        ),
        from = "external_en",
        to = "external_de"
    )

    logger::log_success("Crosswalked column names")

    out
}

# Create project ----------

path <- "~/Code/dbt/dbt.def.data"
usethis::create_tidy_package(path = path)
# usethis::proj_set(path, force = TRUE)

# Dev dependencies --------------------------------------------------------

renv::activate()
renv::upgrade()

renv::install("devtools")
renv::install("testthat")
renv::install("roxygen2")
renv::install("roxygen2md")
renv::install("rmarkdown")
renv::install("here")
renv::install("rlang")
renv::install("httpgd")

renv::snapshot(prompt = FALSE)

# usethis::use_tidy_dependencies()
# usethis::use_tidy_eval()
# rstudioapi::restartSession()

# Dev preps ---------------------------------------------------------------

# Git
usethis::use_git()
usethis::use_git_remote(url = "https://github.com/rappster/dbt-def-lab-001-new.git", overwrite = TRUE)
usethis::git_default_branch_configure()
usethis::use_tidy_contributing()
usethis::use_tidy_support()
usethis::use_tidy_issue_template()
usethis::use_tidy_coc()

# GitHub
usethis::use_tidy_github()
usethis::use_tidy_github_actions()
usethis::use_tidy_github_labels()
usethis::use_tidy_upkeep_issue(year = "2022")
usethis::use_tidy_issue_template()

# "Add the pipe"
usethis::use_pipe()

# Add package description
usethis::use_package_doc(open = FALSE)

# Use {testthat}
usethis::use_package("testthat", type = "Suggests")

# Use markdown in roxygen syntax
usethis::use_roxygen_md()
roxygen2md::roxygen2md()

# Misc
usethis::use_mit_license()
# usethis::use_readme_rmd(open = FALSE)
usethis::use_lifecycle()
usethis::use_lifecycle_badge("experimental")
# usethis::use_news_md(open = FALSE)
usethis::use_tidy_style(strict = TRUE)

dir.create("dev")

usethis::use_build_ignore(c("dev", "inst/examples", "tests"))

# renv::install("rappster/confx")
# usethis::use_dev_package("confx", type = "Imports", remote = "rappster/confx")

# Tests -------------------------------------------------------------------

usethis::use_test("package")

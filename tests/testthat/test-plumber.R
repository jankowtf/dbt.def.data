test_that("hello_world endpoint works", {
  expect_equal(201, httr::GET("/hello_world")$status_code)
})

plumber::plumb("plumber.R")$run(port = 8000)


test_pow <- function() {
  my_db <- rquery_default_db_info()

  td <- mk_td("data", "x")
  ops <- extend(td, xsq = x^2)
  sql <- to_sql(ops, my_db)
  #cat(sql)
  RUnit::checkEquals(1, grep("POWER", sql, fixed = TRUE))

  if (requireNamespace("RSQLite", quietly = TRUE) &&
      requireNamespace("DBI", quietly = TRUE)) {
    raw_connection <- DBI::dbConnect(RSQLite::SQLite(), ":memory:")
    dbopts <- rq_connection_tests(raw_connection)
    db_handle <- rquery_db_info(connection = raw_connection,
                                is_dbi = TRUE,
                                connection_options = dbopts)

    td2 <- rq_copy_to(db_handle, "data", data.frame(x = 2),
               temporary = TRUE, overwrite = TRUE)
    res <- DBI::dbGetQuery(raw_connection, sql)
    DBI::dbDisconnect(raw_connection)
    RUnit::checkEquals(data.frame(x = 2, xsq = 4), data.frame(res))
  }

  invisible(NULL)
}

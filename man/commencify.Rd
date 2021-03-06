% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/materialize.R
\name{commencify}
\alias{commencify}
\title{Hyderdrive (science fiction show) synonym for \code{\link{execute}}}
\usage{
commencify(source, optree, ..., limit = NULL, source_limit = NULL,
  overwrite = TRUE, temporary = TRUE, allow_executor = TRUE,
  temp_source = mk_tmp_name_source("rquery_ex"), env = parent.frame())
}
\arguments{
\item{source}{data.frame or database connecton (rquery_db_info class or DBI connections preferred).}

\item{optree}{relop operation tree.}

\item{...}{force later arguments to bind by name.}

\item{limit}{numeric, if set limit to this many rows during data bring back (not used when landing a table).}

\item{source_limit}{numeric if not NULL limit sources to this many rows.}

\item{overwrite}{logical if TRUE drop an previous table.}

\item{temporary}{logical if TRUE try to create a temporary table.}

\item{allow_executor}{logical if TRUE allow any executor set as rquery.rquery_executor to be used.}

\item{temp_source}{temporary name generator.}

\item{env}{environment to work in.}
}
\value{
data.frame
}
\description{
Run the data query.
}
\examples{

# WARNING: example tries to change rquery.rquery_db_executor option to RSQLite and back.
if (requireNamespace("DBI", quietly = TRUE) && requireNamespace("RSQLite", quietly = TRUE)) {
  my_db <- DBI::dbConnect(RSQLite::SQLite(), ":memory:")
  old_o <- options(list("rquery.rquery_db_executor" = list(db = my_db)))
  d <- rq_copy_to(my_db, 'd',
                   data.frame(AUC = 0.6, R2 = 0.2))
  optree <- extend_se(d, c("v" \%:=\% "AUC + R2", "x" \%:=\% "pmax(AUC,v)"))

  print(optree)

  cat(format(optree))

  v <- execute(my_db, optree)
  print(v)

  v2 <- execute(data.frame(AUC = 1, R2 = 2), optree)
  print(v2)

  options(old_o)
  DBI::dbDisconnect(my_db)
}

}
\seealso{
\code{\link{execute}}
}

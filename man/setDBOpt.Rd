% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/db_ops.R
\name{setDBOpt}
\alias{setDBOpt}
\title{Set a database connection option.}
\usage{
setDBOpt(db, optname, val)
}
\arguments{
\item{db}{rquery_db_info instance}

\item{optname}{character, single option name.}

\item{val}{value to set}
}
\value{
db
}
\description{
If db is of class rquery_db_info it sets the appropriate connection option, not the global state.
}

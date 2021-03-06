% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/fars_function.R
\name{fars_map_state}
\alias{fars_map_state}
\title{Create a map of accidents by state and year}
\usage{
fars_map_state(state.num, year)
}
\arguments{
\item{state.num}{An Integer with the State Code}

\item{year}{A string, or an integer, with the input \code{year}}
}
\value{
None
}
\description{
Displays a plot with a state map including the accidents location by year
If the \code{state.num} is invalid the function shows an error
}
\examples{
\dontrun{
fars_map_state(49, 2015)
}
}
\seealso{
\link{fars_read}

\link{make_filename}
}

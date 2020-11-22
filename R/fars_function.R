# Daviddlhy
# Coursera "Building R Packages"
# Week 2 Assigment -- Documenting Functions
# Nov 7 2020



#' Read file with FARS data
#'
#' This function reads data from .csv file, stored on disk, from the \strong{US
#' National Highway Traffic Safety Administration's} \emph{Fatality Analysis
#' Reporting System} (FARS), which is a nationwide census, providing the
#' American public yearly data, regarding fatal injuries suffered in motor
#' vehicle traffic crashes.
#'
#' @details For more information, see:
#' \itemize{
#'   \item{\url{https://www.nhtsa.gov/research-data/fatality-analysis-reporting-system-fars}}
#'   \item{\url{https://en.wikipedia.org/wiki/Fatality_Analysis_Reporting_System}}
#' }
#' @importFrom readr read_csv
#' @importFrom dplyr as_tibble
#'
#' @param filename A character string with the name of the file to read, see
#'   notes.
#'
#' @return A data frame with data readed from the csv file, or an error if the
#'   file does not exists.
#'
#' @examples
#' library(dplyr)
#' library(readr)
#' \dontrun{
#' yr <- 2015
#' data <- yr %>%
#'   make_filename %>%
#'   fars_read
#' head(data)
#' }
#' @note To generate file name use: \code{\link{make_filename}}
#' @seealso \link{make_filename}
#' @export
fars_read <- function(filename) {
  if(!file.exists(filename))
    stop("file '", filename, "' does not exist")
  data <- suppressMessages({
    readr::read_csv(filename, progress = FALSE)
  })
  dplyr::as_tibble(data)
} 


#' Create a data file name
#'
#' Make .csv data file name related to the given \code{year}
#' The function does not check if the file is available.
#'
#' @param year A string or an integer with the input \code{year}
#'
#' @return This function returns a string with the data file name for a given
#'   year, and the file path within the package.
#'
#' @examples
#' make_filename(2013)
#' @seealso \link{fars_read}
#' @export

make_filename <- function(year) {
  year <- as.integer(year)
  system.file('extdata',
              sprintf('accident_%d.csv.bz2', year),
              package = 'farsdata',
              mustWork = TRUE)
}

#' Read farsdata years
#'
#' Ancillary function used by \code{fars_summarize_years}
#' @param years A vector with a list of years
#'
#' @importFrom dplyr mutate
#' @importFrom dplyr select
#' @importFrom magrittr "%>%"
#
#' @return A data.frame including entries in data by month, or NULL if the
#'  \code{year} is not valid
#'
#' @seealso \link{fars_read}
#' @seealso \link{make_filename}
#' @seealso \link{fars_summarize_years}
#' @examples
#' fars_read_years(2013)
#' @export

fars_read_years <- function(years) {
  lapply(years, function(year) {
    file <- make_filename(year)
    tryCatch({
      dat <- fars_read(file)
      dplyr::mutate(dat, year = year) %>% 
        dplyr::select(MONTH, year)
    }, error = function(e) {
      warning("invalid year: ", year)
      return(NULL)
    })
  })
}


#' Summarize farsdata by years
#'
#' This function summarizes yearly accidents data, by month
#' @param years A vector with a list of years to summarize by.
#'
#' @return A data.frame with number of accidents by years summarized by month
#' @importFrom dplyr bind_rows
#' @importFrom dplyr group_by
#' @importFrom dplyr summarize
#' @importFrom tidyr spread
#' @importFrom magrittr "%>%"
#' @importFrom dplyr n
#' @seealso \link{fars_read_years}
#' @examples
#' \dontrun{
#' plot(fars_summarize_years(2015))
#' fars_summarize_years(c(2015, 2014))
#' }
#' @export

fars_summarize_years <- function(years) {
  dat_list <- fars_read_years(years)
  dplyr::bind_rows(dat_list) %>% 
    dplyr::group_by(year, MONTH) %>% 
    dplyr::summarize(n = n()) %>%
    tidyr::spread(year, n)
}

#' Create a map of accidents by state and year
#'
#' Displays a plot with a state map including the accidents location by year
#' If the \code{state.num} is invalid the function shows an error
#' @param state.num An Integer with the State Code
#' @param year A string, or an integer, with the input \code{year}
#' @importFrom maps map
#' @importFrom dplyr filter
#' @importFrom graphics points
#' @return None
#' @seealso \link{fars_read}
#' @seealso \link{make_filename}
#' @examples
#' \dontrun{
#' fars_map_state(49, 2015)
#' }
#' @export
fars_map_state <- function(state.num, year) {
  filename <- make_filename(year)
  data <- fars_read(filename)
  state.num <- as.integer(state.num)
  
  if(!(state.num %in% unique(data$STATE)))
    stop("invalid STATE number: ", state.num)
  data.sub <- dplyr::filter(data, STATE == state.num)
  if(nrow(data.sub) == 0L) {
    message("no accidents to plot")
    return(invisible(NULL))
  }
  is.na(data.sub$LONGITUD) <- data.sub$LONGITUD > 900
  is.na(data.sub$LATITUDE) <- data.sub$LATITUDE > 90
  with(data.sub, {
    maps::map("state", ylim = range(LATITUDE, na.rm = TRUE),
              xlim = range(LONGITUD, na.rm = TRUE))
    graphics::points(LONGITUD, LATITUDE, pch = 46)
  })
}
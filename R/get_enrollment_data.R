#' @title Get Enrollment Data
#' @description Gets a data frame of enrollment(by class) over the years at Williams College
#' @return A data frame containing enrollment
#' @export
get_enrollment_data <- function(){
  links <- c("http://web.williams.edu/admin/registrar//catalog/bulletin2010-11.pdf",
             "http://web.williams.edu/admin/registrar//catalog/catalog0910.pdf",
             "http://web.williams.edu/admin/registrar//catalog/catalog0809.pdf",
             "http://web.williams.edu/admin/registrar//catalog/catalog0708.pdf",
             "http://web.williams.edu/admin/registrar//catalog/catalog0607.pdf",
             "http://web.williams.edu/admin/registrar//catalog/catalog0506.pdf",
             "http://web.williams.edu/admin/riegistrar//catalog/catalog0405.pdf")
  year <- c(2011, 2010, 2009, 2008, 2007, 2006, 2005)
  enrollment <- lapply(links, get_enrollment)
  grad <- sapply(enrollment, "[[", 1)
  senior <- sapply(enrollment, "[[", 2)
  junior <- sapply(enrollment, "[[", 3)
  sophomore <- sapply(enrollment, "[[", 4)
  freshman <- sapply(enrollment, "[[", 5)
  enrollment_data <- data.frame(year,freshman, sophomore, junior, senior, grad)
  names(enrollment_data) <- c("Year", "Freshmen", "Sophomores", "Juniors", "Seniors", "Graduate")
  return(enrollment_data)
}

#' @title Get Price Data
#' @description Gets a data frame of tuition prices over the years at Williams College
#' @return A data frame containing prices
#' @export
get_price_data <- function(){
  links <- c("http://web.williams.edu/admin/registrar//catalog/bulletin2013_14.pdf",
             "http://web.williams.edu/admin/registrar//catalog/bulletin12_13.pdf",
             "http://web.williams.edu/admin/registrar//catalog/bulletin2011_12.pdf",
             "http://web.williams.edu/admin/registrar//catalog/bulletin2010-11.pdf",
             "http://web.williams.edu/admin/registrar//catalog/catalog0910.pdf",
             "http://web.williams.edu/admin/registrar//catalog/catalog0809.pdf",
             "http://web.williams.edu/admin/registrar//catalog/catalog0708.pdf",
             "http://web.williams.edu/admin/registrar//catalog/catalog0607.pdf",
             "http://web.williams.edu/admin/registrar//catalog/catalog0506.pdf",
             "http://web.williams.edu/admin/registrar//catalog/catalog0405.pdf")
  years <- c(2014, 2013, 2012, 2011, 2010, 2009, 2008, 2007, 2006, 2005)
  prices <- sapply(links, get_price)
  price_data <- data.frame(prices, years)
  rownames(price_data) <- NULL
  names(price_data) <- c("Tuition","Year")
  return(price_data)
}

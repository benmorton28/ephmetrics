#' @title Get Price
#' @description Gets the tuition price from an archived Williams Course Catalog PDF link
#' @param link A link to a yearly pdf file on the Williams College Registrar's website.
#' @return Price of tuition for that academic year
#' @importFrom pdftools pdf_text
#' @importFrom string str_replace_all
#' @export
download_data <- function(link= "http://web.williams.edu/admin/registrar//catalog/catalog0910.pdf"){
  download.file(link, destfile = "./catalog0910.pdf")
  text <- pdftools::pdf_text("./catalog0910.pdf")
  concatenated_text <- paste(text, collapse = "")
}

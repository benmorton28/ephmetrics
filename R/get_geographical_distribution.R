#' @title Get Geographical Distribution
#' @description Gets the geographical distribution data from a archived Williams Course Catalog PDF link.
#' @param link A link to a yearly pdf file on the Williams College Registrar's website.
#' @return A dataframe with two columns:country and count
#' @importFrom pdftools pdf_text
#' @importFrom string str_replace_all
#' @export
download_data <- function(link= "http://web.williams.edu/admin/registrar//catalog/catalog0910.pdf"){
  download.file(link, destfile = "./catalog0910.pdf")
  text <- pdftools::pdf_text("./catalog0910.pdf")
  concatenated_text <- paste(text, collapse = "")
  replaced_text <- stringr::str_replace_all(concatenated_text, "[\n]" , " ")
  replaced_text_2 <- gsub("\\s+"," ",replaced_text)
  tokenized_text <- strsplit(replaced_text_2, " ")[[1]]
}

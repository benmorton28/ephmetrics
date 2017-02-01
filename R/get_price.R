#' @title Get Price
#' @description Gets the tuition price from an archived Williams Course Catalog PDF link
#' @param link A link to a yearly pdf file on the Williams College Registrar's website.
#' @return Price of tuition for that academic year
#' @importFrom pdftools pdf_text
#' @importFrom stringr str_replace_all
#' @export
get_price <- function(link= "http://web.williams.edu/admin/registrar//catalog/catalog0910.pdf"){
  download_path <- paste("./inst/extdata/", basename(link), sep = "")
  if(!file.exists(download_path)){
    download.file(link, destfile = download_path)
  }
  text <- pdftools::pdf_text(download_path)
  concatenated_text <- paste(text, collapse = "")
  replaced_text <- stringr::str_replace_all(concatenated_text, "[\n]" , " ")
  replaced_text <- gsub("\\s+", " ", replaced_text)
  replaced_text <- gsub(".*(College charges)", "", replaced_text)
  word_list <- strsplit(replaced_text, split = ' ')[[1]]
  cost <- word_list[grep('[$].*', word_list)[1]]
  cost <- as.numeric(substring(gsub(',', '', cost), 2, nchar(cost)))
  return(cost)
}

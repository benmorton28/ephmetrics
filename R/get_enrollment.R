#' @title Get Enrollment
#' @description Gets the enrollment by year(at the beginning of the academic year) from an archived Williams Course Catalog PDF link
#' @param link A link to a yearly pdf file on the Williams College Registrar's website.
#' @return A numeric vector containing enrollment by year, from graduate, and then senior to freshman.
#' @importFrom pdftools pdf_text
#' @importFrom stringr str_replace_all
#' @export
get_enrollment <- function(link= "http://web.williams.edu/admin/registrar//catalog/catalog0910.pdf"){
  download_path <- paste("./inst/extdata/", basename(link), sep = "")
  if(!file.exists(download_path)){
    download.file(link, destfile = download_path)
  }
  text <- pdftools::pdf_text(download_path)
  concatenated_text <- paste(text, collapse = "")
  replaced_text <- stringr::str_replace_all(concatenated_text, "[\n]" , " ")
  replaced_text <- gsub("\\s+"," ",replaced_text)
  replaced_text <- gsub(".*(BY CLASSES)","",replaced_text)
  word_list <- strsplit(replaced_text, split = ' ')[[1]]
  cost <- word_list[grep('^[0-9]+$', word_list)]
  return(as.numeric(word_list[grep('^[0-9]+$', word_list)[c(2,4,6,8,10)]]))
}

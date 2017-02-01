#' @title Get Geographical Distribution
#' @description Gets the geographical distribution data from a archived Williams Course Catalog PDF link.
#' @param link A link to a yearly pdf file on the Williams College Registrar's website.
#' @return A list of size two with two dataframes(one domestic, one international) with two columns:state/country and number.
#' @importFrom pdftools pdf_text
#' @importFrom stringr str_replace_all str_trim str_extract_all
#' @export
get_geographical_distribution <- function(link= "http://web.williams.edu/admin/registrar//catalog/catalog0910.pdf"){
  download_path <- paste("./inst/extdata/", basename(link), sep = "")
  if(!file.exists(download_path)){
    download.file(link, destfile = download_path)
  }
  text <- pdftools::pdf_text(download_path)
  concatenated_text <- paste(text, collapse = "")
  replaced_text <- stringr::str_replace_all(concatenated_text, "[\n]" , " ")
  replaced_text <- gsub("\\s+"," ",replaced_text)
  replaced_text <- gsub(".*(GEOGRAPHICAL DISTRIBUTION)","",replaced_text)
  domestic <- gsub(".*(U.S. )","",replaced_text)
  domestic <- stringr::str_trim(gsub("(International).*","",domestic))
  domestic <- str_extract_all(domestic, "[A-Z][^0-9]+[0-9]+")[[1]]
  domestic_names <- stringr::str_replace_all(domestic, "[0-9]+" , "")
  domestic_numbers <- stringr::str_replace_all(domestic, "[^0-9]+" , "")
  domestic_df <- data.frame(domestic_names, domestic_numbers)
  names(domestic_df) <- c("State","Number")
  international <- stringr::str_trim(gsub(".*(International)","",replaced_text))
  international <- str_extract_all(international, "[A-Z][^0-9]+[0-9]+")[[1]]
  international_names <- stringr::str_replace_all(international, "[0-9]+" , "")
  international_numbers <- stringr::str_replace_all(international, "[^0-9]+" , "")
  international_df <- data.frame(international_names, international_numbers)
  names(international_df) <- c("Country","Number")
  return(list(domestic_df, international_df))
}

#install.packages("FAOSTAT")
require(FAOSTAT)
options(timeout = 600)


data_folder <- paste0("/code/outputs")


available_datasets <- get_faostat_bulk_list()
valid_codes <- available_datasets$dataset_code

# Get user-provided codes
code_list_raw <- Sys.getenv("code_list")
user_codes <- trimws(unlist(strsplit(code_list_raw, ",")))

# Check which codes are valid
invalid_codes <- setdiff(user_codes, valid_codes)

# Exit if there are invalid codes
if(length(invalid_codes) > 0) {
  cat("Error: The following dataset codes are invalid:\n")
  cat(paste(invalid_codes, collapse = ", "), "\n")
  quit(save = "no", status = 1)
}

data_codes <- data.frame(data_codes = user_codes, stringsAsFactors = FALSE)

f <- data_codes$data_codes[1]
for(f in data_codes$data_codes){
  
    get_faostat_bulk(code=f, data_folder = paste0(data_folder),subset = "All Data Normalized")
  
}
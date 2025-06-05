# Install and load the FAOSTAT package if not already installed
if (!requireNamespace("FAOSTAT", quietly = TRUE)) {
  install.packages("FAOSTAT")
}
library(FAOSTAT)

# --- Configuration ---
# Define the environment variable name that holds the FAOSTAT dataset codes
env_var_name <- "code_list"
# Define the relative path for the output folder
output_folder <- "outputs" # This will create an 'outputs' folder in your working directory

# --- Main Script ---

# 1. Retrieve dataset codes from the environment variable
fao_codes_string <- Sys.getenv(env_var_name)

if (nchar(fao_codes_string) == 0) {
  stop(paste("Error: Environment variable '", env_var_name, "' is not set or is empty. Please set it with comma-separated FAOSTAT dataset codes.", sep = ""))
}

# Split the string into individual codes
fao_codes <- unlist(strsplit(fao_codes_string, ","))
fao_codes <- trimws(fao_codes) # Remove leading/trailing whitespace

message(paste("Attempting to download the following FAOSTAT datasets:", paste(fao_codes, collapse = ", ")))

# 2. Get available FAOSTAT dataset metadata to check for existence
message("Fetching available FAOSTAT dataset metadata for validation...")
fao_datasets_metadata <- FAOsearch()

# 3. Check if all provided codes exist in the FAOSTAT metadata
missing_codes <- setdiff(fao_codes, fao_datasets_metadata$code)

if (length(missing_codes) > 0) {
  stop(paste("Error: The following FAOSTAT dataset codes were not found:",
             paste(missing_codes, collapse = ", "),
             "\nPlease check the codes for typos or refer to `FAOsearch()` for available datasets.", sep = ""))
} else {
  message("All provided FAOSTAT dataset codes are valid. Starting download...")
}

# 4. Download datasets
downloaded_data <- list()
for (code in fao_codes) {
  message(paste("Downloading dataset:", code, "..."))
  tryCatch({
    data <- get_faostat_bulk(code = code)
    downloaded_data[[code]] <- data
    message(paste("Successfully downloaded dataset:", code))
  }, error = function(e) {
    warning(paste("Failed to download dataset '", code, "': ", e$message, sep = ""))
  })
}

# ---
### 5. Process and Save Downloaded Data
---

if (length(downloaded_data) > 0) {
  message("\nDownload complete. Saving downloaded data to the 'outputs' folder...")

  # Create the output folder if it doesn't exist
  if (!dir.exists(output_folder)) {
    dir.create(output_folder, recursive = TRUE) # recursive=TRUE ensures parent directories are created if needed
    message(paste("Created output folder:", file.path(getwd(), output_folder)))
  }

  # Save each downloaded dataset to a separate RDS file within the output folder
  for (code in names(downloaded_data)) {
    file_path <- file.path(output_folder, paste0(code, "_data.rds"))
    saveRDS(downloaded_data[[code]], file = file_path)
    message(paste("Saved", code, "to", file_path))
  }

  message("All downloaded datasets have been saved to the 'outputs' folder.")

} else {
  message("No datasets were successfully downloaded.")
}
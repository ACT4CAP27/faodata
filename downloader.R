#install.packages("FAOSTAT")
require(FAOSTAT)


FAO.version <- "2024jan04"
#create directory for the raw data
data_folder <- paste0("FAOSTAT_",FAO.version)
dir.create(paste0(data_folder))

#datasets to obtain given by their names
data_codes <- data.frame(data_codes=c("QCL", ##Production # Crops and livestock products
                                      "QI",               # Production Indices
                                      "QV",               # Value of Agricultural Production
                                      "FS",  ## Food Security and Nutrition # Suite of Food Security Indicators
                                      "FBS", ## Food Balances # Food Balances (2010-)
                                      "SCL",                  # Supply Utilization Accounts (2010-)
                                      "CB",                   # Commodity Balances (non-food)(2010-)
                                      "FBSH",                 # Food Balances (-2013, old methodology and population)
                                      "CBH",                  # Commodity Balances (non-food)(-2013, old methodology)
                                      "TCL", ## Trade # Crops and livestock products
                                      "TM",           # Detailed trade matrix
                                      "TI",           # Trade Indices
                                      "PP", ## Prices # Producer Prices
                                      "CP",           # Consumer Price Indices
                                      "PD",           # Deflators
                                      "PE",           # Exchange Rates
                                      "RL", ## Land, Inputs and Sustainability # Land use
                                      "LC",                                    # Land Cover
                                      "RFN",                                   # Fertilizers by Nutrient
                                      "RFB",                                   # Fertilizers by Product
                                      "EMN",                                   # Livestock Manure  
                                      "RP",                                    # Pesticides Use
                                      "RT",                                    # Pesticides Trade
                                      "ESB",                                   # Cropland Nutrient Balance
                                      "EK",                                    # Livestock Patterns
                                      "ET",                                    # Temperature change on land
                                      "CAHD", ## Cost and Affordability of a Healthy Diet # (CoAHD)
                                      "OEA", ## Population and Employment # Employment Indicators: Agriculture
                                      "OER",                              # Employment Indicators: Rural
                                      "OA",                               # Population
                                      "IG", ## Investment # Government Expenditure
                                      "IC",               # Credit to Agriculture
                                      "EA",               # Development Flows to Agriculture
                                      "FDI",              # Foreign Direct Investment (FDI)
                                      "CISP",             # Country Investment Statstics Profile
                                      "MK", ## Macro-Economic Indicators # Macro Indicators
                                      "CS",                              # Capital Stock
                                      "GFDI", ## Food Value Chain # Value shares by industry and primary factors
                                      "GT", ## Climate Change: Agrifood systems emissions # Emissions totals
                                      "EM",                                               # Emissions indicators
                                      "EI",                                               # Emissions intensities
                                      "GCE",                                              # Emissions from Crops
                                      "GLE",                                              # Emissions from Livestock  
                                      "GN",                                               # Emissions from Energy use in agriculture
                                      "GF",                                               # Emissions from Forests
                                      "GI",                                               # Emissions from Fires
                                      "GV",                                               # Emissions from Drained organic soils
                                      "GPP",                                              # Emissions from pre and post agricultural production                                            
                                      "FO",  ## Forestry # Forestry Production and Trade
                                      "SDGB", ## SDG Indicators
                                      "WCAD", ## World Census of Agriculture # Structural data from agricultural censuses
                                      "FT", ## Discontinued archives and data series # Forestry Trade Flows
                                      "HS",                                          # Indicators from Household Surveys
                                      "AF",                                          # ASTI-Researchers
                                      "AE",                                          # ASTI-Expenditures
                                      "FA",                                          # Food Aid Shipments (WFP)
                                      "RM",                                          # Machinery
                                      "RY",                                          # Machinery Archive
                                      "RA",                                          # Fertilizers archive
                                      "PA")                                          # Product Prices (old series)
                           )

f <- data_codes$data_codes[1]
for(f in data_codes$data_codes){
  
    get_faostat_bulk(code=f, data_folder = paste0(data_folder),subset = "All Data Normalized")
  
}
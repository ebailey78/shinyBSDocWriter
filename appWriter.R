createApp <- function(family, path, deploy = FALSE) {
  
  appname <- gsub(" ", "", family, fixed = TRUE)
  appname <- gsub("_", "", appname, fixed = TRUE)
  
  dir <- paste0("Apps/", appname)
  
  dir.create(dir, showWarnings = FALSE)
  
  infile <- file.path(path, "man", paste0(gsub(" ", "_", family, fixed = TRUE), ".Rd"))
  Rd <- tools:::prepare_Rd(tools::parse_Rd(infile, verbose = FALSE))
  tags <- tools:::RdTags(Rd)
  ex <- Rd[tags == "\\examples"][[1]][[2]]
  
  libraries <- paste0(ex[grep("^library", ex)], collapse = "")
  
  ui.start <- grep("ui *=", ex)
  server.start <- grep("server *=", ex)
  
  ui <- ex[(ui.start + 1):(server.start-1)]
  ui[[length(ui)]] <- ")\n" 
  ui <- paste0(libraries, paste0(ui, collapse = ""))
  
  server = paste0(libraries, "shinyServer(\n", paste0(ex[(server.start+1):(length(ex)-1)], collapse = ""), ")")
  
  writeLines(ui, paste(dir, "ui.R", sep = "/"))
  writeLines(server, paste(dir, "server.R", sep = "/"))
  
  if(deploy)
    shinyapps::deployApp(appDir = normalizePath(dir), appName = appname, launch.browser = FALSE)
    
}
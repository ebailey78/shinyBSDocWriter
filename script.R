path <- "C:/R/shinyBS"
source("docWriter.R")
source("appWriter.R")

# Families
x <- list(
  list(family = "Alerts", functions = c("bsAlert", "createAlert", "closeAlert")),
  list(family = "Modals", functions = c("bsModal", "toggleModal")),
  list(family = "Buttons", functions = c("bsButton", "updateButton")),
  list(family = "Collapses", functions = c("bsCollapse", "bsCollapsePanel", "updateCollapse")),
  list(family = "Tooltips and Popovers", functions = c("bsTooltip", "addTooltip", "removeTooltip", "bsPopover", "addPopover", "removePopover"))
)

# Loop through families writing documentation pages
for(y in x) {
  
 filename <- paste0("docpages/", gsub(" ", "_", y$family, fixed = TRUE), ".html")
 
 createDocPage(filename, y$family, y$functions, path)
  
}

# Loop through families publishing example apps
for(y in x) {

  createApp(y$family, path, TRUE)
  
}

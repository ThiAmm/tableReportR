#' Reduces a data table
#' @param data the data table
#' @param keyColumnNames the column names which are the key to the table (i.e. a unique identifier of an element of the table)
#' @param stringWhichReplacesData

reduceData <- function(data, keyColumnNames, stringWhichReplacesData = '') {
  library(dplyr)

  colnamesOfData <- colnames(data)
  valueColumnNames <- setdiff(colnamesOfData, keyColumnNames)
  lapply(1:(length(keyColumnNames) - 1), function(cardinalityOfSubsetOfKeyColumnNames) {
    subsettedKeyColumnNames <-
      combn(x = keyColumnNames, m = cardinalityOfSubsetOfKeyColumnNames)
    apply(subsettedKeyColumnNames, 2, function(subsettedKeyColumnName) {
      keyColumnNamesToTestReducability <- setdiff(keyColumnNames, subsettedKeyColumnName)
      groupVector <- c(subsettedKeyColumnName, valueColumnNames)
      data <<-
        data %>% inner_join(data %>% group_by(!!!syms(groupVector)) %>% summarise(cardinalityOfGroupVector =
                                                                                    n()),
                            by = groupVector) %>% inner_join(data %>% group_by(!!!syms(subsettedKeyColumnName)) %>% summarise(cardinalityOfKeyGroups = n()),
                                                             by = subsettedKeyColumnName)
      if (all(rowSums((data %>% select(subsettedKeyColumnName)) == stringWhichReplacesData) !=
          length(subsettedKeyColumnName))) {
        lapply(keyColumnNamesToTestReducability, function(keyColumnNameToTestReducability) {
          data <<-
            data %>% mutate(
              !!keyColumnNameToTestReducability := ifelse(
                data$cardinalityOfGroupVector == cardinalityOfKeyGroups,
                stringWhichReplacesData,
                data[[keyColumnNameToTestReducability]]
              )
            )
        })
      }
      data <<- data %>% distinct() %>% select(colnamesOfData)
    })
  })
  Filter(function(x)
    ! all(x == stringWhichReplacesData), data)
}

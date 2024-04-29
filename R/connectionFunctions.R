########################################################
# Basic R function for the package.
# Author: Mathieu Fortin, Canadian Forest Service, Canadian Wood Fibre Centre
# Copyright; Her Majesty the Queen in right of Canada
# Date: April 2019
########################################################


jarFilenames <- c("betadivcalc-1.0.3.jar", "repicea-1.10.4.jar", "repicea-mathstats-1.3.13.jar")


.welcomeMessage <- function() {
  packageStartupMessage("Welcome to betadiv package! This package implements estimators of beta diversity indices.")
  packageStartupMessage("For more information, visit https://github.com/CWFC-CCFB/betadiv .")
}

.onDetach <- function(libpath) {
  shutdownClient()
}

.onUnload <- function(libpath) {
  shutdownClient()
}

.onAttach <- function(libname, pkgname) {
  .welcomeMessage()
}

#'
#' Extend the visibility of the shutdownClient function in J4R.
#'
#' @export
shutdownClient <- function() {
  if (J4R::isConnectedToJava()) {
    J4R::shutdownClient()
  }
}

.addToArray <- function(refArray, array) {
  if (length(refArray) != length(array)) {
    stop("Incompatible array length!")
  } else {
    for (i in 1:length(array)) {
      refArray[[i]] <- c(refArray[[i]], array[[i]])
    }
  }
  return(refArray)
}

.convertJavaDataSetIntoDataFrame <- function(dataSetObject) {
  refArray <- NULL
  observations <- J4R::callJavaMethod(dataSetObject, "getObservations")
  observations <- J4R::getAllValuesFromListObject(observations)
  for (obs in observations) {
    array <- J4R::callJavaMethod(obs, "toArray")
    array <- as.list(J4R::getAllValuesFromArray(array))
    if (is.null(refArray)) {
      refArray <- array
    } else {
      refArray <- .addToArray(refArray, array)
    }
  }
  dataFrame <- NULL
  for (i in 1:length(refArray)) {
    dataFrame <- as.data.frame(cbind(dataFrame, refArray[[i]]))
  }
  colnames(dataFrame) <- J4R::getAllValuesFromListObject(J4R::callJavaMethod(dataSetObject, "getFieldNames"))
  return(dataFrame)
}

.getLibraryPath <- function(packageName, jarFilename) {   #### TODO this method should stop if the jarFilename does not exist and not return NULL
  filename <- system.file(jarFilename, package = packageName)
  if (all(file.exists(filename))) {
    filePath <- filename
  } else {
    stop(paste("At least one of these files cannot be found in the installation:", paste(jarFilenames, collapse = ",")))
  }
  return(filePath)
}


.loadLibrary <- function(memSize = NULL) {
  if (J4R::isConnectedToJava()) {
    for (jarName in jarFilenames) {
      if (!J4R::checkIfClasspathContains(jarName)) {
        stop(paste("It seems J4R is running but the class path does not contain this library: ", jarName, ". Shut down J4R using the shutdownClient function first and then re-run your code."))
      }
    }
  } else {
    path <- .getLibraryPath("betadiv", jarFilenames)
    J4R::connectToJava(extensionPath = path, memorySize = memSize)
    for (jarName in jarFilenames) {
      if (!J4R::checkIfClasspathContains(jarName)) {
        stop(paste("It seems J4R has not been able to load the", jarName, "library."))
      }
    }
  }
}




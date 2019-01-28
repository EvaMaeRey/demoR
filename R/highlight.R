hlt_specific <- function(code_string, specs, hltcolor = "red") {
  ## Returns string of code_string with all (occurrences of) specs colored in hltcolor

  ## code_string must contain only code; no placeholders or other html

  hlt_pieces <- txt_color(specs, hltcolor)

  print_string <- reduce2(c(code_string, specs), hlt_pieces, str_replace)

  txt_tocode(print_string)
}


hlt_args <- function(code_string, ...) {
  ## Returns string of code_string with all argument names colored in hltcolor

  ## code_string must contain only code; no placeholders or other html

  strpieces <- strsplit(code_string, split = "=")[[1]]
  args <- unlist(strsplit(strpieces[1:length(strpieces)], split = "\\(|, "))
  args <- trimws(funs[grepl(" $", args)])
  ## argument names should always immediately follow an open parentheses or comma space,
  ## and immediately preceed a space equals

  hlt_specific(code_string, args, ...)

}

hlt_funs <- function(code_string, ...) {
  ## Returns string of code_string with all functions colored in hltcolor

  ## code_string must contain only code; no placeholders or other html

  strpieces <- strsplit(code_string, split = "\\(")[[1]]
  funs <- sapply(strsplit(strpieces[1:(length(strpieces)-1)], split = " "), function(x) x[length(x)])
  ## function names should always immediately preceed an open parentheses

  hlt_specific(code_string, funs, ...)

}

hlt_vars <- function(code_string, ...) {
  ## Returns string of code_string with all variable inputs colored in hltcolor

  ## code_string must contain only code; no placeholders or other html

  strpieces <- strsplit(code_string, split = "=")[[1]]
  vars <- unlist(strsplit(strpieces[1:length(strpieces)], split = "\\)|, "))
  vars <- funs[grepl("^ ", vars)]
  vars <- trimws(funs[!grepl("[[:punct:]]", vars)])
  ## variable names should always immediately preceed a closed parentheses or comma,
  ## and immediately follow a space

  hlt_specific(code_string, vars, ...)
}
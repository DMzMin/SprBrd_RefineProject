x <- data.frame(x = 1:6, y = paste(letters[1:6], "-", 1:6))
x


y <- data.frame(x = 1:6, y = paste0(letters[1:6], "-", 1:6))
y

y %>% separate(col = y, into = c("letter", "number"))

glimpse(y)

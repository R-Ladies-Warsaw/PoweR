# R / RStudio
# co jest czym w RStudio?



## Operatory +, -, *, /, ...
2 + 2
2 + 2 + 2 + 2
2^4

## Zadanie 1 
# sprawdz czy R zachowuje kolejnosc dzialan. Jakiego przykladu mozna uzyc?




## Operator przypisania w R
x <- 5
x
y = 5

zmienna <- "Hello World!"

## Wektory
parzyste <- c(2, 4, 6)
litery <- c("a", "b", "c")

litery[2]

vec <- c(parzyste, litery)
vec

## Operacje na wektorach
nieparzyste <- c(1, 3, 5)

parzyste + nieparzyste
parzyste * x


## Listy

liczby <- list(parzyste = parzyste, nieparzyste = nieparzyste)
c(parzyste, nieparzyste)

liczby[[1]]
liczby[["parzyste"]]


##Zadanie 2
# a) Stworz dwa wektory skladajace sie z 5 liczb kazdy, a nastepnie przypisz ich roznice do nowej zmiennej o nazwie roznica.
# b) Polacz te trzy wektory w liste



## Funkcje z base
?min

min(roznica)
max(roznica)
sum(roznica)

length(roznica)

vec2 <- 1:20
vec2
vec3 <- 50:100
vec3


## Ramki danych
df <- data.frame(col_1 = c(1, 2, 3), col_2 = c("raz", "dwa", "trzy"))

# Operatory
df$col_1
df[3, 1]
df[ ,1]
df[1, ]
df[2:3, ]



## Instrukcje warunkowe

1 == 1
1 == 0
1 > 0
1 < 0

!(1==1)

parzyste
parzyste == 2

all(parzyste == 2)
any(parzyste == 2)
2 %in% parzyste

if( !(8 %in% parzyste) ){
  parzyste <- c(parzyste, 8)
}
parzyste

skorupa <- TRUE
if(skorupa == TRUE){
  "zolw"
} else {
  "kot"
}

ifelse(skorupa == TRUE, "zolw", "kot")
# ifelse dziala tez na wektorze
skorupa <- c(TRUE, TRUE, FALSE)
ifelse(skorupa == TRUE, "zolw", "kot")

## Zadanie 3
# a) Podobnie jak w powyższym przykładzie, wektor liczb nieparzystych powieksz o liczbe 7, o ile juz jej nie ma.
# b) Dany jest wektor liczb, v <- c(1,2,2,2,2,2,3,3,3,1,1,2). Uzyj
# instrukcji if else lub ifelse, zeby zrobic z niego wektor zawierajacy
# wartosci "jeden", "dwa", "trzy".




## Petle
while (length(parzyste) < 10) {
  len <- length(parzyste)
  parzyste <- c(parzyste, parzyste[len] + 2)
}


nieparzyste2 <- c()
for(liczba in parzyste){
  nieparzyste2 <- c(nieparzyste2, liczba - 1)
}

## Zadanie 4
# Uzyj petli (ktorej?), zeby iterujac po wektorze `liczby <- 1:10` stworzyc wektor 10 kolejnych liczb nieparzystych.
# Czy jest wiecej niz jeden sposob?






# Sciezki
getwd()
setwd()

# Wczytywanie plikow
seriale <- read.csv("<tu nalezy wkleic sciezke do pliku>", sep=";")
#seriale <- read.csv("netflix_titles.csv")

head(seriale)
View(seriale)


### Zadanie 5
## Wypisz: 
# a) nazwy seriali, ktore wyszly w 2020 roku.
# b) Z ramki danych seriale wybierz podzbior zawierajacy Twoje 3 ulubione seriale i przypisz go do nowej zmiennej.




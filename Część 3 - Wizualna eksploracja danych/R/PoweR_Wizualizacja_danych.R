###                                                       ###
###      Warsztaty PoweR 05 - Wizualizacja danych w R     ###
###                                                       ###



# Będziemy dzisiaj pracować z pakietem ggplot2
# Instalcja 
install.packages("ggplot2")
# Dane z pakietu PogromcyDanych
install.packages("PogromcyDanych")


library(ggplot2)
library(PogromcyDanych)
library(dplyr)



###                                                       ###
###           Kilka słów o wizualizacji danych            ###
###                                                       ###

# Jakie mamy dane?
serialeIMDB
head(serialeIMDB)

# Szybkie przypomnienie z ostatnich warsztatów

# wymiar ramki danych
dim(serialeIMDB)

# liczba seriali w zbiorze danych
length(unique(serialeIMDB$serial))

# minimalna/średnia/maksymalna ocena
summary(serialeIMDB$ocena)


###                                                       ###
###                  Jak działa ggplot2?                  ###
###                                                       ###

# Wybierzmy sobie jeden serial

wybrany_serial <-  c("House M.D.")

serialeIMDB %>%
  filter(serial == wybrany_serial)


dane_House <- serialeIMDB %>%
  filter(serial == wybrany_serial)


head(dane_House)

# wykres z ggplot2

# mamy obszar wykresu
ggplot(data = dane_House)

# w jaki sposób zrobić wykres? 

# na początek musimy określi mapowanie - czyli jakie zmienne przyjmiemy na osi x (i osi y)
# do tego używamy aes()


#zaczniemy od jednego wymiaru - histogram 
ggplot(data = dane_House, mapping = aes(x = ocena))

# ale gdzie są nasze słupki?
# w ggplot2 używamy "warstw", które nakładamy na siebie
# poszczególne warstwy łączymy ze sobą znakiem "+"

ggplot(data = dane_House, mapping = aes(x = ocena)) + geom_histogram()

# możemy wykres przypisywać do zmiennej

nasz_wykres <- ggplot(data = dane_House, mapping = aes(x = ocena)) + geom_histogram()
nasz_wykres
str(nasz_wykres)


ggplot(data = dane_House, mapping = aes(x = ocena)) +
  geom_histogram()

# możemy używać %>% przy przekazaniu danych, jak w dplyr

dane_House %>% 
  ggplot(mapping = aes(x = ocena)) +
  geom_histogram()


# a inna szerokość kubełków lub inna ich liczba - nie ma sprawy
ggplot(data = dane_House, mapping = aes(x = ocena)) +
  geom_histogram(bins = 10)

ggplot(data = dane_House, mapping = aes(x = ocena)) +
  geom_histogram(binwidth = 0.5)


# czy to dobry wykres? 
# gdzie jest tytuł?

ggplot(data = dane_House, mapping = aes(x = ocena)) +
  geom_histogram(binwidth = 0.5) +
  ggtitle("Histogram oceny odcinków serialu House M.D.")

# opisy osi zostaja takie jak podajemy w aes()
# czy możemy zmienić opisy osi - pewnie!

ggplot(data = dane_House, mapping = aes(x = ocena)) +
  geom_histogram(binwidth = 0.5) +
  ggtitle("Histogram oceny odcinków serialu House M.D.") +
  xlab("Ocena") + 
  ylab("Częstość")

#### Zadanie 1 ####
# Narysuj histogram liczby głosów wybranego serialu.
# Podpisz osie oraz dodaj tytuł.

# ggplot(data = dane_House, mapping = aes(x = glosow)) +
#   geom_histogram() +
#   ggtitle("Histogram liczby głosów dla odcinków serialu House M.D.") +
#   xlab("Liczba głosów") + 
#   ylab("Częstość")

# to teraz dwa wymiary - na pierwszy ogień wykres słupkowy

ggplot(data = dane_House, mapping = aes(x = id, y = ocena)) + 
  geom_bar(stat = "identity")

# wysokie oceny, ale zobaczmy tylko na pierwszy sezon

dane_House %>%
  filter(sezon == 1) %>%
  ggplot(aes(x = odcinek, y = ocena)) + 
  geom_bar(stat = "identity")
  
# czy widzimy tu problem?
# numery odcinków nie są po kolei - dlaczego?

dane_House %>%
  filter(sezon == 1) %>%
  str()
# bo numery odcinków nie są liczbami tylko factor
# zamieńmy na numeric

dane_House$odcinek <- as.numeric(dane_House$odcinek)

# a teraz?
dane_House %>%
  filter(sezon == 1) %>%
  ggplot(aes(x = odcinek, y = ocena)) + 
  geom_bar(stat = "identity")

# widzimy, że mamy barkującą obserwacje

## Czy nasze wykresy muszą być takie smutne i szare? - Nie
# możemy zmienić kolor słupków

dane_House %>%
  filter(sezon == 1) %>%
  ggplot(aes(x = odcinek, y = ocena)) + 
  geom_bar(stat = "identity", color = "blue")

dane_House %>%
  filter(sezon == 1) %>%
  ggplot(aes(x = odcinek, y = ocena)) + 
  geom_bar(stat = "identity", color = "blue", fill = "blue")


# Możemy zmieniać też motywy

dane_House %>%
  filter(sezon == 1) %>%
  ggplot(aes(x = odcinek, y = ocena)) + 
  geom_bar(stat = "identity", color = "blue", fill = "blue") + 
  theme_bw()

dane_House %>%
  filter(sezon == 1) %>%
  ggplot(aes(x = odcinek, y = ocena)) + 
  geom_bar(stat = "identity", color = "blue", fill = "blue") + 
  theme_classic()

dane_House %>%
  filter(sezon == 1) %>%
  ggplot(aes(x = odcinek, y = ocena)) + 
  geom_bar(stat = "identity", color = "blue", fill = "blue") + 
  theme_minimal() + 
  ggtitle("Ocena odcinków pierwszego sezonu serialu House M.D.") +
  xlab("Odcinek") + 
  ylab("Ocena")

# Możemy tworzyć własne motywy, które będą opisywały każdy parametr naszego wykresu


#### Zadanie 2 ####
# Narysuj wykres pokazujący ocenę pierwszych odcinków dla każdego sezonu.
# Zmień kolor obramowanie słupków na czerwony, a wypełnienie na biały.
# Podpisz osie oraz dodaj tytuł.

# dane_House %>%
#   filter(odcinek == 1) %>%
#   ggplot(aes(x = sezon, y = ocena)) + 
#   geom_bar(stat = "identity", color = "red", fill = "white") + 
#   theme_minimal() + 
#   ggtitle("Ocena pierwszych odcinków sezonu serialu House M.D.") +
#   xlab("Sezon") + 
#   ylab("Ocena")



# a jakbyśmy chcieli zobaczyć jak rozkładają się oceny odcinków względem sezonów (mamy już wykres słupkowy, 
# ale przy takiej liczbie słupków może jest lepszy pomysł) - boxplot

?geom_boxplot

# zobaczymy na jednym sezonie
dane_House %>%
  filter(sezon == 1) %>%
  ggplot(aes(x = ocena)) + 
  geom_boxplot()
  
# teraz wszystkie sezony
dane_House %>%
  ggplot(aes(x = ocena, y = sezon)) + 
  geom_boxplot()

# trochę ciężko nam to czytać - a jak obrócimy o 90 stopni?
dane_House %>%
  ggplot(aes(x = ocena, y = sezon)) + 
  geom_boxplot() + 
  coord_flip()

# dodajmy podpisy osi
dane_House %>%
  ggplot(aes(x = ocena, y = sezon)) + 
  geom_boxplot() + 
  coord_flip() + 
  labs(x = "Sezon", y = "Ocena", title = "Ocena odcinków per sezon serialu House M.D.")

# warstwy warstwy
dane_House %>%
  ggplot(aes(x = ocena, y = sezon)) + 
  geom_boxplot() + 
  coord_flip() + 
  labs(x = "Ocena", y = "Sezon", title = "Ocena odcinków per sezon serialu House M.D.")

# lub
dane_House %>%
  ggplot(aes(x = ocena, y = sezon)) + 
  geom_boxplot() + 
  labs(x = "Ocena", y = "Sezon", title = "Ocena odcinków per sezon serialu House M.D.") +
  coord_flip() 

# wykresy punktowe
?geom_point()


#sprawdzmy czy jest zależność oceny odcinka od liczby głosów

dane_House %>%
  ggplot(aes(x = ocena, y = glosow)) + 
  geom_point()

# a jakbyśmy chcieli uzwględnić jeszcze sezon?
# kolor
dane_House %>%
  ggplot(aes(x = ocena, y = glosow, color = sezon)) + 
  geom_point()

#kształt 
dane_House %>%
  ggplot(aes(x = ocena, y = glosow, shape = sezon)) + 
  geom_point()
#mamy tylko 6 dostępnych

#sprawdźmy kształt dla pierwzego i ostatniego sezonu
dane_House %>%
  filter(sezon == 1 | sezon == 8) %>%
  ggplot(aes(x = ocena, y = glosow, shape = sezon)) + 
  geom_point()

#### Zadanie 3 ####
# Narysuj wykres boxplot dla liczby głosów w poszczególnych sezonach, 
# oznacz kolorem każdy sezon.

# dane_House %>%
#   ggplot(aes(x = glosow, y = sezon, color = sezon)) + 
#   geom_boxplot() + 
#   labs(x = "Ocena", y = "Sezon", title = "Liczba głosów per sezon serialu House M.D.") +
#   coord_flip() 

## czy ta się wypełnić? - tak

dane_House %>%
  ggplot(aes(x = glosow, y = sezon, fill = sezon)) + 
  geom_boxplot() + 
  labs(x = "Ocena", y = "Sezon", title = "Liczba głosów per sezon serialu House M.D.") +
  coord_flip() 

# czy użycie kolorów ma tutaj senes? - tak średnio 
# ale gdy będziemy rozważać na przykład więcej seriali- tak

wybrane_seriale <- c("House M.D.", "Breaking Bad")

serialeIMDB %>%
  filter(serial %in% wybrane_seriale) %>% 
  ggplot(aes(x = ocena, y = sezon, color = serial)) + 
  geom_boxplot() + 
  labs(x = "Ocena", y = "Sezon", title = "Ocena odcinków per sezon dla House M.D. i Breaking Bad") +
  coord_flip() 

serialeIMDB %>%
  filter(serial %in% wybrane_seriale) %>% 
  ggplot(aes(x = ocena, y = sezon, fill = serial)) + 
  geom_boxplot() + 
  labs(x = "Ocena", y = "Sezon", title = "Ocena odcinków per sezon dla House M.D. i Breaking Bad") +
  coord_flip() 


# facet - czyli robicie na "okienka"
?facet_grid
?facet_wrap



serialeIMDB %>%
  filter(serial %in% wybrane_seriale) %>% 
  ggplot(aes(x = ocena, y = sezon)) + 
  geom_boxplot() + 
  labs(x = "Ocena", y = "Sezon", title = "Ocena odcinków per sezon dla House M.D. i Breaking Bad") +
  coord_flip() +
  facet_wrap("serial")

serialeIMDB %>%
  filter(serial %in% wybrane_seriale) %>% 
  ggplot(aes(x = ocena, y = sezon)) + 
  geom_boxplot() + 
  labs(x = "Ocena", y = "Sezon", title = "Ocena odcinków per sezon dla House M.D. i Breaking Bad") +
  coord_flip() +
  facet_wrap(~serial)


#gdy chcemy uzależnić od dwóch zmiennych
serialeIMDB %>%
  filter(serial %in% wybrane_seriale) %>% 
  ggplot(aes(x = ocena, y = sezon)) + 
  geom_boxplot() + 
  labs(x = "Ocena", y = "Sezon", title = "Ocena odcinków per sezon dla House M.D. i Breaking Bad") +
  coord_flip() +
  facet_grid(sezon~serial)


# sprawdźmy jak wygląda ocena odcinków w sezonie dla tych serialii
  serialeIMDB %>%
  filter(serial %in% wybrane_seriale) %>% 
  ggplot(aes(x = odcinek, y = ocena, color = serial)) + 
  geom_bar(stat = "identity") +
  facet_grid(sezon~serial)
  
# problem z odcinakami, bo factor
  seriale <-  serialeIMDB %>%
    filter(serial %in% wybrane_seriale)
  seriale$odcinek <- as.numeric(seriale$odcinek)
  
  ggplot(seriale, aes(x = odcinek, y = ocena)) + 
    geom_bar(stat = "identity") +
    facet_grid(sezon~serial)
  
  ggplot(seriale, aes(x = odcinek, y = ocena)) + 
    geom_bar(stat = "identity") +
    facet_wrap(sezon~serial)
  
# średnia ocena na sezon
  serialeIMDB %>%
    filter(serial %in% wybrane_seriale) %>%
    group_by(serial, sezon) %>%
    summarise(srednia = mean(ocena)) %>%
    ggplot(aes(x = sezon, y = srednia, fill = serial)) + 
    geom_bar(stat = "identity")

#stat = "count"
#position = "stack"
  
  serialeIMDB %>%
    filter(serial %in% wybrane_seriale) %>%
    group_by(serial, sezon) %>%
    summarise(srednia = mean(ocena)) %>%
    ggplot(aes(x = sezon, y = srednia, fill = serial)) + 
    geom_bar(stat = "identity", position = "dodge")

#### Zadanie 4 ####
# Wybierz dowolny serial/seriale i spróbuj narysować wykres zależności
# oceny od numeru odcinka/sezonu.


#import the small user NRS SPD file (19-2)

library(readr)
rm()
SmallUser1 <- read_csv("SmallUser.csv")

#view smalluser dataframe

View(SmallUser1)

#keep only necessary columns:
#Postcode, DateOfDeletion, SplitIndicator, DataZone2011Code

SmallUser2 <- subset(SmallUser1, select = c(Postcode, DateOfDeletion, SplitIndicator, DataZone2011Code))
nrow(SmallUser2)
#should be 190700 rows(postcodes)


#keep only postcodes that have not been deleted

SmallUser3 <- SmallUser2[is.na(SmallUser2$DateOfDeletion),]
SmallUser3 <- subset(SmallUser3, select = c(Postcode, SplitIndicator, DataZone2011Code))
nrow(SmallUser3)
View(SmallUser3)

#should be 152226

#separate the suffix for split postcode using RIGHT function from helpers
SmallUser4 <- SmallUser3
SmallUser4$PostcodeAB <- RIGHT(SmallUser4$Postcode,1)

#replace unsplit postcodes' suffixes with "N"
SmallUser4$PostcodeAB <- ifelse(SmallUser4$SplitIndicator=="Y", SmallUser4$PostcodeAB, "N")

#keep unsplit postcodes and A postcodes only (remove B postcodes from dataset)
SmallUser4 <- subset(SmallUser4, SmallUser4$PostcodeAB!= "B")

#check the figures are correct
table(SmallUser4$PostcodeAB)
table(SmallUser4$SplitIndicator)
nrow(SmallUser4)
View(SmallUser5)

#remove superfluous columns (postcode and data zone code need merging with SIMD 2020 figures)
SmallUser5 <- subset(SmallUser4, select = c(Postcode, DataZone2011Code))

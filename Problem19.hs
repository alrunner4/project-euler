
import Utils

class ( Show a ) => Abbreviate a where
  abbr :: a -> String
  abbr = ( take 2 ) . show

data WeekDay = Monday | Tuesday | Wednesday | Thursday | Friday | Saturday | Sunday
  deriving ( Show )

instance Abbreviate WeekDay

instance Sequence WeekDay where
  after Monday = Tuesday
  after Tuesday = Wednesday
  after Wednesday = Thursday
  after Thursday = Friday
  after Friday = Saturday
  after Saturday = Sunday
  after Sunday = Monday

isLeapYear y | ( y `mod` 400 ) == 0 = True
             | ( y `mod` 100 ) == 0 = False
             | ( y `mod` 4 ) == 0   = True
             | otherwise            = False

data MonthName = January | February | March | April | May | June | July | August | September | October | November | December
  deriving ( Show )

instance Abbreviate MonthName where
  abbr = ( take 3 ) . show

instance Sequence MonthName where
  after January = February
  after February = March
  after March = April
  after April = May
  after May = June
  after June = July
  after July = August
  after August = September
  after September = October
  after October = November
  after November = December
  after December = January

data Month = Month MonthName Integer WeekDay
  deriving ( Show )

lengthOf ( Month January   _ _ ) = 31
lengthOf ( Month February  y _ ) | isLeapYear y = 29
                                 | otherwise    = 28
lengthOf ( Month March     _ _ ) = 31
lengthOf ( Month April     _ _ ) = 30
lengthOf ( Month May       _ _ ) = 31
lengthOf ( Month June      _ _ ) = 30
lengthOf ( Month July      _ _ ) = 31
lengthOf ( Month August    _ _ ) = 31
lengthOf ( Month September _ _ ) = 30
lengthOf ( Month October   _ _ ) = 31
lengthOf ( Month November  _ _ ) = 30
lengthOf ( Month December  _ _ ) = 31

instance Sequence Month where
  after ( Month December y d ) = Month January ( y + 1 ) ( d `advanceSequence` 31 )
  after ( Month m y d ) = Month ( after m ) y ( d `advanceSequence` ( lengthOf $ Month m y d ) )

monthsSince m = scanl advanceSequence m ( repeat 1 )

problem19 = show $
            length $
            filter startsOnSunday $
            takeWhile ( \ ( Month _ y _ ) -> y < 2001 ) $
            monthsSince $
            ( Month January 1900 Monday ) `advanceSequence` 12
  where
    startsOnSunday ( Month _ _ Sunday ) = True
    startsOnSunday ( Month _ _ _      ) = False

main = putStrLn problem19

module Exercise1.TypeClass where

import Prelude

newtype DateRange = DateRange
  { startDate :: String
  , endDate :: String
  }

instance eqDateRange :: Eq DateRange where
  eq (DateRange dateRange1) (DateRange dateRange2) =
    dateRange1.startDate == dateRange2.startDate && dateRange1.endDate == dateRange2.endDate

instance showDateRange :: Show DateRange where
  show (DateRange dateRange) =
    "DateRange { startDate: " <> dateRange.startDate <> ", endDate: " <> dateRange.endDate <> " }"

execute :: String
execute =
  let
    dateRange1 = DateRange { startDate: "2023-01-01", endDate: "2023-01-31" }
    dateRange2 = DateRange { startDate: "2023-01-01", endDate: "2023-01-31" }
    dateRange3 = DateRange { startDate: "2023-02-01", endDate: "2023-02-28" }
  in
    if dateRange1 == dateRange2 then
      "dateRange1 is equal to dateRange2: " <> show dateRange1
    else if dateRange1 == dateRange3 then
      "dateRange1 is equal to dateRange3: " <> show dateRange1
    else
      "No equality found"

module Exercise1.TypeClass where

import Prelude

newtype Person = Person { name :: String, age :: Int }

instance eqPerson :: Eq Person where
  eq (Person { name: name1, age: age1 }) (Person { name: name2, age: age2 }) =
    name1 == name2 && age1 == age2

instance showPerson :: Show Person where
  show (Person { name: name, age: age }) =
    "Person { name: " <> name <> ", age: " <> show age <> " }"

execute :: String
execute =
  let
    person1 = Person { name: "Alice", age: 30 }
    person2 = Person { name: "Alice", age: 30 }
    person3 = Person { name: "Bob", age: 25 }
  in
    if person1 == person2 then
      "person1 is equal to person2: " <> show person1
    else if person1 == person3 then
      "person1 is equal to person3: " <> show person1
    else
      "No equality found"

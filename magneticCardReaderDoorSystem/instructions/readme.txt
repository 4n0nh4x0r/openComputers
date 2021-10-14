-- FileName --
The filename of an instruction sheet must be made up of the magnetic card reader and the suffix ".lua"
example : 3bbdd537-f117-4d4a-bc48-6adc766fb243.lua
          |___________________________________|___|
		               Filename                Suffix


-- Content --
The content of an instruction sheet is basically an array.
This array contains the address of the door controller, and the magstripe card codes that are allowed to go in.

example : 
accessArray = {
  ["doorController"] = "91b601d3-19eb-4762-9073-8f2a208accc2",    -- This is the address of the controller that the MagCard reader is supposed to work with --
  ["allowed"] = {
    "18873940",                                                   -- Here are the codes of the cards that can use the card reader --
    "11225543"                                                    -- This can be anything, numbers, characters, special characters, it doesnt matter --
  }
}


-- How to create a magstripe access card --
You need the cardwriter.
Then you go to lua input mode, and type in :
component.os_cardwriter.write("18873940", "The name of the card you want")
done, now you have a keycard that has the code "18873940" on it.


-- Sample --
This is a sample that you can use in notepad++ for example, and put your values in, and then copy paste it into your game when you are done.

accessArray = {
  ["doorController"] = "",
  ["allowed"] = {
    ""
  }
}

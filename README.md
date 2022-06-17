Not-On-Spotify

Not-on-spotify allows users to signin through the CLI, which creates a User or signs in and defines the CLI class variable @@me as a certain user, which lasts until they sign out again.

Users can enter Artists and their Albums, can add Links to those albums and dispute other links on the albums, and can save albums to their personal collections.

The capstone features of Not-On_spotify are the search_on_spot method, the check_on_lastfm method and the ActiveRecord database. The search method checks Spotify's API(using gem rpsotify) to see if the album is saved in Spotify's database(i.e. if it is on spotify). The check method references Lastfm's API(through gem lasttfm) to make sure the particular spelling of the album and artist names entered are correct(as lastfm has its onw databse of popular music, and includes albums which aren't on spotify).

The features that were "close but no cigar" were a method that could check all albums in a personal collection to see if anya re on spotify(which was working minutes up until my rpesentation), and a series of methods which populated albums with details from Lastfm's API(which was also rickety and thus not included in the final product, however, it is more or less functional in the album model, but not the cli).


Original, day-one User-Stories:

As a user, I want to be able to search if an album is on spotify, and if not, if it has already been added to the not-on-spotify database

As a user, I want to access information about albums in the not-on-spotify database, including their artist, the songs contained in the album, and especially links to the album on other non-spotify streaming services 

As a user, I want to add albums into the not-on-spotify-database, and pull albums from the database into my own personal collection

As a user, I want to check if any albums in my personal collection have been added to spotify since I last used the application

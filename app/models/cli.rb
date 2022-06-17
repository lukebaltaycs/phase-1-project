class Cli

    @@me = ""

    
    def self.me
        @@me
    end

    def self.me=(me)
        @@me=me
    end

    def self.clear_charts
        Album.delete_all
        Artist.delete_all
        User.delete_all
        PersonalCollection.delete_all
        AlbumCollect.delete_all
        Link.delete_all
        LastFmClone.delete_all
    end

    def self.login_page
        if User.all.empty?
            Cli.no_accounts
        else
           n = nil
            while n == nil
                puts ""
                puts "Enter one of the already registered usernames, or enter 'new' to create an additional account:\n\n"
                Cli.display_accounts
                entered_name = gets.chomp
                if entered_name == "new" || entered_name == "New" || entered_name == "NEW" || entered_name == "n" || entered_name == "N"
                    puts ""
                    puts "Enter a username to begin interacting with the database:\n\n"
                    n = Cli.create_account.name
                    Cli.me = User.all.find_by(name: n)
                    Cli.me.save
                elsif User.all.map{|user| user.name}.include?(entered_name)
                   n = entered_name
                   Cli.me = User.all.find_by(name: n)
                   Cli.me.save
                end
            end
        end
        puts ""
        puts "Welcome to the 'Not-On-Spotify' Database, #{Cli.me.name}.\n\n"
        Cli.main_menu
    end

    def self.display_accounts
        User.all.each do |user|
            puts "  #{user.name}\n"
            if user.personal_collections.count == 1
                puts "      #{user.personal_collections.count} personal collection created"
            elsif 
                puts "      #{user.personal_collections.count} personal collections created"
            end
            if user.album_collects.count == 1
                puts "      #{user.album_collects.count} albums saved\n\n"
            elsif
                puts "      #{user.album_collects.count} albums saved\n\n"
            end
        end
    end

    def self.no_accounts
        puts ""
        puts "No users have been registered yet. Enter a username to begin interacting with the database:\n\n"
        new_account = Cli.create_account
        Cli.me = new_account
    end

    def self.create_account
        n = nil
        while n == nil
        username = gets.chomp
            if username != "new" && username != "New" && username != "NEW" && username != "N" && username != "n" && !User.all.map{|user| user.name}.include?(username)
                n = username
                new_acc = User.create(name: n)
            else
                puts ""
                puts "Username must be unique and cannot be 'new'. Enter another name, please:\n\n"
            end
        end
        new_acc
    end


    def self.view_all_albums
        Album.all.each {|album| puts album.return_album_info}
    end

    def self.view_all_artists
        Artist.all.each do |artist|
            puts artist.name
            puts "#{artist.albums.count} albums registered in the database"
            puts ""
        end
    end

    def self.put_library
        puts ""
        puts "These are the artists currently in the database:"
        Cli.view_all_artists
        puts ""
        puts "These are the albums currently in the database:"
        Cli.view_all_albums
        puts ""
    end

    def self.add_artist(artist_name)
        new_artist = Artist.create(name: artist_name)
        new_artist.check_name_on_lastfm
        if artist_name != new_artist.name
            answer = ""
            puts "'#{artist_name}' was auto-corrected to '#{new_artist.name}'. Is this okay? (Y/n)"
            while answer != "Y" && answer != "n" 
                puts "Please answer 'Y' or 'n'"           
                answer = gets.chomp
            end
            if answer == "n"
                puts "This may hurt NotOnSpotify's ability to gather correct information from external databases."
                new_artist.update_attribute(:name, artist_name)
            end
        end
        new_artist.save
        puts "#{new_artist.name} was added to database."
    end

    def self.main_menu
        puts "Enter 'D' to view database, 'S' to check if an album is on Spotify, 'P' to enter the Personal Collections menu, or 'R' to logout and return to login page\n\n"
        input = gets.chomp
        if input == "D"
            Cli.library
        elsif input == 'R'
            Cli.login_page
        elsif input == 'S'
            Cli.spot_check
        elsif input== 'P'
            Cli.personal_collections_menu
        end
    end

    def self.personal_collections_menu
    input = ""    
        while input != 'M'
            puts "Enter 'V' to view your personal collection, '-' to delete an album from your personal collection, 'S' to check all albums in your personal collection on Spotify, or 'M' to return to the main menu\n\n"
            input = gets.chomp
            inputs = input.split(" ")
            rest_inputs = inputs.drop(1).join(" ")
            if inputs[0] == "V"
               puts Cli.me.personal_collections.first.albums.each{|album| puts album.return_album_info}
            elsif inputs[0] == '-'
                Cli.me.album_collects.find_by(album: Album.all.find_by_name(rest_inputs)).delete
            elsif inputs[0] = 'S'
                puts Cli.me.personal_collections.first.check_all_on_spotify
            end
        end
        Cli.main_menu
    end

    def self.library
        Cli.put_library
        input = ""
        while input != 'M'
            puts "Enter 'L' to view database contents again, '+' followed by an artist name to enter a new artist, '+A' followed by an Album name to enter a new album, 'A' followed by an album to view or edit an existing album, or 'M' to return to the main menu\n\n"
            input = gets.chomp
            inputs = input.split(" ")
            rest_inputs = inputs.drop(1).join(" ")         
            if input[0] == "L"
                Cli.put_library
                puts ""
            elsif inputs[0] == "+"
                Cli.add_artist(rest_inputs)
                puts ""
            elsif inputs[0] == "+A"
                Cli.add_album(rest_inputs)
                puts ""
            elsif input[0] == "A"
                if Album.find_by_name(rest_inputs) != nil
                    Cli.edit_album(Album.find_by_name(rest_inputs))
                else
                    puts "#{rest_inputs} is not in the database."
                    puts "Add #{rest_inputs} to the database? (Y/n)"
                    puts ""
                    answer = ""
                    while answer != "Y" && answer != "n" 
                        puts "Please answer 'Y' or 'n'"           
                        answer = gets.chomp
                    end
                    if answer == "Y"
                        Cli.add_album(rest_inputs)
                    else
                        puts "Returning to database.\n\n"
                    end
                end    
            elsif input[0] == 'M'
                Cli.main_menu
            end
        end
    end

    def self.add_album(album_name)
        puts "What artist should #{album_name} be attributed to?"
        artist_name = gets.chomp
        if !Artist.all.map{|artist| artist.name}.include?(artist_name) 
            puts "Artist was not in database, but was just added."
            Cli.add_artist(artist_name)
        end
        Artist.find_by(name: Artist.last.name).enter_album(album_name)
        new_album = Album.find_by_name(album_name)
        new_album.check_name_on_lastfm
        if album_name != new_album.name
            answer = ""
            puts "'#{album_name}' was auto-corrected to '#{new_album.name}'. Is this okay? (Y/n)"
            while answer != "Y" && answer != "n" 
                puts "Please answer 'Y' or 'n'"           
                answer = gets.chomp
            end
            if answer == "n"
                puts "This may hurt NotOnSpotify's ability to gather correct information from external databases."
                new_album.update_attribute(:name, album_name)
            elsif answer == "Y"
                new_album.add_last_fm_clone
            end
        end
        new_album.save
        puts "#{new_album.name} was added to database."        
    end

    def self.add_album_froms(album_name, artist_name)
        if !Artist.all.map{|artist| artist.name}.include?(artist_name) 
            puts "Artist was not in database, but was just added."
            Cli.add_artist(artist_name)
        end
        Artist.find_by(name: Artist.last.name).enter_album(album_name)
        new_album = Album.find_by_name(album_name)
        new_album.check_name_on_lastfm
        if album_name != new_album.name
            answer = ""
            puts "'#{album_name}' was auto-corrected to '#{new_album.name}'. Is this okay? (Y/n)"
            while answer != "Y" && answer != "n" 
                puts "Please answer 'Y' or 'n'"           
                answer = gets.chomp
            end
            if answer == "n"
                puts "This may hurt NotOnSpotify's ability to gather correct information from external databases."
                new_album.update_attribute(:name, album_name)
            elsif answer == "Y"
                new_album.add_last_fm_clone
            end
        end
        new_album.save
        puts "#{new_album.name} was added to database."        
    end

    def self.edit_album(album)
        puts ""
        puts "Currently viewing #{album.name} by #{album.artist.name}"
        input = ""
        while input != 'D'
            puts "Enter 'D' to return to the database menu, 'V' to view the album details, '-L' followed by a site name to dispute one of this album's links, '+L' followed by a url to add a link, or '+PC' to add this album to your personal collection, or 'AA' to view all albums by this album's artist\n\n"
            input = gets.chomp
            inputs = input.split(" ")
            rest_inputs = inputs.drop(1).join(" ") 
            if inputs[0] == 'V'
                puts album.return_album_info
                if album.last_fm_clones.first != nil
                    puts album.last_fm_clones.first.summary
                end
            elsif inputs[0] == '-L'
                puts album.link_is_invalid(rest_inputs)
            elsif inputs[0] == '+L'
                Cli.me.add_link(album, rest_inputs)
                album.save
            elsif inputs[0] == '+PC'
                Cli.me.personal_collections.first.add_album(album)
                puts "#{album.name} has been added to your personal collection"
            elsif inputs[0] == 'AA'
                puts "#{album.artist.name}:\n"
                album.artist.albums.each{|alb| puts alb.return_album_info}
            end
        end 
        Cli.library
        #add to PC ('+PC')
    end

    def self.check_artist_on_lfm(artist_name)
        lastfm = Lastfm.new("227863264027c5a3c3408d22a1fe992d", "2d1e640d3a44317c1ca713516f822727")
        lfmname = lastfm.artist.search(artist: artist_name)["results"]["artistmatches"].first[1][0]["name"]
        if artist_name != lfmname
            answer = ""
            puts "'#{artist_name}' was auto-corrected to '#{lfmname}'. Is this okay? (Y/n)"
            while answer != "Y" && answer != "n" 
                puts "Please answer 'Y' or 'n'"           
                answer = gets.chomp
            end
            if answer == "n"
                puts "This may hurt NotOnSpotify's ability to gather correct information from external databases."
                return artist_name
            else
                return lfmname
            end
        else
            return artist_name
        end
    end

    def self.spot_check
        puts "Enter an album name to check if it is on spotify:"
        album_name = gets.chomp
        puts "Enter an artist name:"
        artist_name = gets.chomp
        artist_name = check_artist_on_lfm(artist_name)
        #puts artist_name
        lastfm = Lastfm.new("227863264027c5a3c3408d22a1fe992d", "2d1e640d3a44317c1ca713516f822727")
        #lfmname = lastfm.album.search(album: album_name)["results"]["albummatches"].first[1].find{|album| album["artist"] = artist_name}["name"]
        lfmname = lastfm.album.search(album: album_name)["results"]["albummatches"].first[1].first["name"]
        searchname = album_name
        if lfmname != album_name
            puts "'#{album_name}' was auto-corrected to '#{lfmname}'. Is this okay? (Y/n)"
            answer = ""
            while answer != "Y" && answer != "n" 
                puts "Please answer 'Y' or 'n'"           
                answer = gets.chomp
            end
            if answer == "n"
                searchname = album_name
            else
                searchname = lfmname
            end
        end
        RSpotify.authenticate("2e00d0bdfb384b909cec10a4c8159835", "600b4d53025a4066b7d2bafd74f99cd6")
        init = RSpotify::Album.search(searchname)
        #if init == nil || !init.collect{|album| album.artists.first.name}.include?(artist_name)
        if !init.collect{|album| album.name}.include?(searchname) || !init.collect{|album| album.artists.first.name}.include?(artist_name)
            puts "'#{searchname}' is not on spotify. Would you like to add it using the information you've given?"
            answer = ""
            while answer != "Y" && answer != "n" 
                puts "Please answer 'Y' or 'n'"           
                answer = gets.chomp
            end
            if answer == "Y"
                Cli.add_album_froms(album_name, artist_name)
            end
        else
            puts "Good news! '#{album_name}' is indeed on Spotify. Happy listening!"
        end
        Cli.main_menu
    end



    def self.artist_menu
        input = ''
        puts "These are the artists currently in the database:\n\n"
        Cli.view_all_artists
        while input != 'D'
            puts "Enter 'D' to return to Database menu, '+' followed by an artist name to enter a new artist, or 'S' followed by an artist name to edit an artist\n\n"
            input = gets.chomp
            inputs = input.split(" ")
            rest_inputs = inputs.shift
            if inputs[0] == "S"
                if Artist.find_by_name(rest_inputs) != nil
                    Cli.edit_artist(Artist.find_by_name(rest_inputs))
                else
                    puts "#{rest_inputs} is not in the database."
                    "Add #{rest_inputs} to the database? (Y/n)"
                    answer = ""
                    while answer != "Y" && answer != "n" 
                        puts "Please answer 'Y' or 'n'"           
                        answer = gets.chomp
                    end
                    if answer == "Y"
                        Cli.add_artist(rest_inputs)
                        puts ""
                    end
                end                
            elsif inputs[0] == "+"
                Cli.add_artist(rest_inputs)
                puts ""
            end
        end
        Cli.library
    end

    ##gone
    def self.edit_artist(artist)
        input = ''
        puts artist.name
        puts "#{artist.albums.count} albums registered in the database"
        puts ""
        while input != 'E'
            puts "Enter 'A' to return to Artist menu, '+' followed by an album name to enter a new album, or 'S' followed by an artist name to edit an artist\n\n"
            puts ""
            input = gets.chomp
            inputs = input.split(" ")
            if inputs[0] == "S"
                Cli.add_artist(inputs[1])
            elsif inputs[0] == "+"
                Cli.edit_artist(inputs[1])
            end
        end
        Cli.library
    end


end
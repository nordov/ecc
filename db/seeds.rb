# CLean slate
User.destroy_all
Game.destroy_all

# Keeps track of created uers ids
newUsers = []
#Keep tracks of recorded game names to avoid duplicates
gameNames = []
index = 0
# Can choose how many users and how many game records to produce
userQty = 5
gameQty = 15

# Creating the users
userQty.times do
    user = User.new
    user.name = Faker::Name.name
    user.email = Faker::Internet.email
    user.password = 'default123'
    user.password_confirmation = 'default123'
    user.save!
    newUsers.push(user.id)
end

gameQty.times do 

    # Generates a name and then if it was already used, it generates another
    # From 29 to 36
    gameName = ''

    loop do
        gameName = Faker::Game.title
        break if !(gameNames.include?(gameName))
    end

    gameNames.push(gameName)

    gameNickname = Faker::Lorem.word
    gameLikes = Faker::Number.between( from: 0, to: 99 )
    gameDislikes = Faker::Number.between( from: 0, to: 99 )

    # Generates a random number that will be used to call a decorative image
    gameImage = Faker::Number.between( from: 1, to: 11 )


    game = Game.create(
        name: gameName,
        nickname: gameNickname,
        likes: gameLikes,
        dislikes: gameDislikes,
        publisher_id: newUsers[ index ],
        image: gameImage
    )

    # Add to user's regisyered_games count
    user = User.find_by( id: newUsers[ index ] )
    user.add_registered_game


    if ( index < userQty - 1 ) then
        index += 1
    else
        index = 0
    end
end

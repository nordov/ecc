class GameController < ApplicationController
    before_action :authenticate_user!, :except => [:index, :show, :search, :upvote, :downvote]

    def index
        @games = Game.all
    end

    def my_account
        @games = Game.where( :publisher_id => current_user.id )
        render :index
    end
    
    def show
        @game = Game.find_by( id: params[ :id ] )
    end

    def create
        @game = Game.new(game_params)

        @game.publisher_id = current_user.id
        @game.image = rand(1...11)

        if @game.save
            current_user.add_registered_game
            redirect_to game_path( @game.id )
        else
            redirect_to new_game_path, alert: "Error creating"
        end
    end

    def edit
        @game = Game.find_by( id: params[ :id ])
    end

    def update
        @game = Game.find_by( id: params[ :id ])
        @game.name = game_params[ :name ]
        @game.nickname = game_params[ :nickname ]

        if @game.save
            redirect_to game_path( @game.id )
        else
            redirect_to game_path( @game.id ), alert: "Error updating game"
        end
    end

    def destroy
        @game = Game.find_by( id: params[ :id ])

        if @game.delete
            current_user.remove_registered_game
            redirect_to my_account_path, alert: "Game deleted"
        else
            redirect_to game_path( @game.id ), alert: "Error deleting game"
        end
    end

    def search
        search_term = search_params[ :term ]
        @games = Game.where( "name like ?", "%#{search_term}%")
    end

    def upvote 
        @game = Game.find_by( id: params[ :id ])
        @game.upvote
        redirect_to root_path
    end

    def downvote
        @game = Game.find_by( id: params[ :id ])
        @game.downvote
        redirect_to root_path
    end

    private
        # Parameter requirements
        def game_params
            params.require( :game ).permit( :name, :nickname, :likes, :dislikes, :publisher )
        end

        def search_params
            params.require( :search ).permit( :term )
        end
end

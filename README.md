# ECC

ECC is a code challenge project. It presents a Game APP Catalog scenario. A collection of Game APP records with minimal data can be displayed in a main index for all users, with the additional options of viewing a detail page of each and also submitting up votes and down votes.

Its main purpose is to illustrate a CRUD app made with Ruby on Rails. It currently presents two models, User and Game, and both can be Created, Read, Updated and Displayed.


## Setup

* Ruby on Rails is required https://guides.rubyonrails.org/v5.1/getting_started.html

* The application can be cloned from https://github.com/nordov/ecc.git

* Run `bundle install` to install all the dependencies, including SQLite3 which is the DB used for this project

* To setup the database and populate some seeding data first run `$rails db:create` and then `$rails db:seed`. The seeding file can be found in `db/seeds.rb`. By default it creates 5 users and 15 game records but that can be easily changed by changing the values of `userQty` and `gameQty` in lines 11 and 12

* Rails server can be started by running `$rails server`, then you can browse to http://localhost:3000 to load web application


## Stack
* Ruby on Rails 6.1.7

* Device: Rails gem that quickly deploys authentication and authorization in the app.

* Bootstrap CND for quick styling and app presentation

## Models

### User

Created by Devise it has the basic user fields and validations. Some fields were added for app features such as a field for the user's name and another to keep track of how many games the user has registered

**User Schema**

|  Field  |  Type |  Validation  |
| ---------- | ---------- | ---------- |
| Name | String | Not NULL |
| Email | String | Not NULL |
| Password | String | Not NUll, Min 6 chars |
| Registered Games | Integer | Not NULL, default to 0 |

> Other fields not currently relevant to the APP exist per Devise features


**User Associations**

* has many => Games

**User Methods**

* `add_registered_game`: Adds count of games registered to the user.
* `remove_registered_game`: Removes regsitered game from the users count when a game gets deleted

**Game Schema**

|  Field  |  Type |  Validation  |
| ---------- | ---------- | ---------- |
| Name | String | Not NULL |
| Nickname | String | Not NULL |
| Image | Integer | Not NUll |
| Likes | Integer | Not NULL, default to 0 |
| Dislikes | Integer | Not NULL, default to 0 |
| Publisher ID | Integer | Not NULL, Foreign key |

**User Associations**

* Belongs to => Publisher 
> Publisher being the user


**Game Methods**

* `upvote`: Increases the likes field count
* `downvote`: Increases the dislikes field count

## Relevant Routes

* `root (/game/)`: Renders public index o all game apps
* `/game/:id/show`: Renders game record. It is read only unless the user is signed in and is the publisher of the game 
* `/my-account` : Displays signed in user own registered games
* `/game/:id/upvote`: Endpoint to trigger an upvote
* `/game/:id/downvote`: Endpoint to trigger a downvote
* `/game/search`: Search query of term entered in search bar

> Other common routes exist for each model CRUD

## Improvement Opportunities

* Validations can be strengthen. Currently user related inputs are safe due to Devise but other validatios such as password conditions can be implemented

* The app is currently small enough to load quickly. If the app was to be scaled some consideratoins would be necessary such agination and Lazyload of game records at Index. Also it is now relaying in the Active Record ORM of rails and with a high volume if traffic performance can be impacted. In that case implementing direct SQL queries could give better performance

* Better catch of errors and exception handling could be implemented. Due to time constraints methods are built without error handling such as record savings, request param filtering and others. Also better error messages could be displayed for better UX.

* There is a basic cashing option running by Rail default behavior but other cashing options supported by cookies and local storage to help scenarios were there was heavy traffic



##LAB2
1) Creation of static pages for our social network: home and concact 

	
- `rails generate controller Pages home contact`
	
2) Creation of the "About" page, by editing the files:

- `config/routes.rb`
 	
- `app/controllers/pages_controller.rb`
	
3) Adding title to HTML files: "Room5T | Page name"

- by defining a `@title` variable in `app/controllers/pages_controller.rb`
	
- by including it in the title present in `app/views/layouts/application.html.erb`

4) Create an helper to only show the title "Room5T" if the `@title` variable is nil

##LAB5
5) Improve the helper, by using symbols instead of instance variables

6) Add the [Bootstrap CSS Framework](http://twitter.github.com/bootstrap/ "Twitter Bootstrap"):

- update the gemfile to download and install `bootstrap-sass`

- `bundle install`

- create a new file for custom CSS, such as `custom.css.scss`; fill its content with `@import "bootstrap";`

- add some partials to separate logical units

- add custom Sassy CSS

##LAB6
7) Add routes for existing pages and delete or rename the page public/index.html

8) Create, stylish and add proper named routes to:

- the help page

- a User controller, with  `new` as an action (and `\signup` as relative URL)

##LAB7
9) Install some useful gems: `annotate` and `bcrypt-ruby`

10) Generate a User model with two attributes, name and email:

- `rails generate model User name:string email:string`

11) Migrate the model to a DB:

- `bundle exec rake db:migrate`

12) \[If you are using Rails version 3.2.1 or earlier\] Add the line `attr_accessible :name, :email` to the User model (the `user.rb` file)

13) Add some validations for the model attributes

14) Assure the uniqueness to the email attribute, by acting on the DB

##LAB8
15) Create a migration for the password digest (then, migrate it):

- `rails generate migration add_password_digest_to_users password_digest:string`

16) Add password and password_confirmation to user's model

17) Create a new user in the DB (probably this change is not under version control)

##LAB9
18) Show some useful debug information in the web pages by adding the `debug` method to `application.html.erb`

- add some custom stylesheet rules for debug purposes

19) Add a route for handling the User resource:

- `resources :users`

20) Add a new page for showing a user (otherwise, the added route does not show anything...): `show.html.erb`

- add some information to the page and some stylesheet rules

21) Add an helper to connect with the Gravatar service

22) Add the sign up form by using the helper method `form_for`

- add some stylesheet rules to the form

- add the `@user` variable to the `new` action in the UsersController

23) Add the `create` action to the UsersController to handle the creation of new users by using the sign up form

24) Add signup error messages in the `_error_messages.html.erb` shared partial

25) Add the flash in the `application.html.erb`, i.e., a message that appears on a page and then dissappears upon visiting a second page or on page reload

##LAB10
26) Add sessions for sign in/out; realized with a controller and a cookie for the model

- we implemented a permanent sign in: the user will be logged out only if she'll execute an explicit sign out

- add a secure remember token on the model for each user and store it as a permanent cookie rather than one that expires on browser close

- add bootstrap.js to the app assets

- update the existing users to support the new functionalities

27) Add the functionalities for editing, showing and deleting users

28) Add some fake users to the site

- add the gem named faker

- add a rake task to generate fake users (`sample_data.rake`)

- `bundle exec rake db:populate`

29) Add pagination functionalities for showing all the users

- add the gems named gem will_paginate and bootstrap-will_paginate

30) Create administrative users: the ones who can delete other registered users

- create a migration `add_admin_to_users`

- update the existing users

##LAB 11

31) Create a Micropost model and its migration

- `rails generate model Micropost content:string user_id:integer`

- add a index in order to retrieve all the microposts associated with a given user id in reverse order of creation

- since we want that a micropost belongs to a specific existing user, we must create a new micropost using micropost.user.create instead of Micropost.create. In this way, each user has her micropost and each micropost belong to a specific user.

- add a descendent order for the microposts

32) Automatically destroy all the microposts of a destroyed user

33) Show the micropost in the single user page

34) Update the `sample_data` rake task to insert some fake microposts for the first six users

35) Add some stylesheet rules for visualizing the microposts

36) Add the possibility to create a micropost via web interface

- add a signed_in helper (in the session helpers) to assure that no micropost will be created without a user signed in

- update controllers and error partial to handle micropost creation

37) Add the destroy functionality for microposts

##LAB 12

38) Add a new model, Relationship, to handle following mechanism with:

- two (integer) fields, `follower_id` e `followed_id`

- three indexes, two for efficiency and one to ensure that a user can't follow another user more than once

39) Update the User model for following mechanism (`has_many` and follow/unfollow methods) and the Relationship model (`belongs_to` and some validations)

40) Update the `populate` rake task

41) Update the interface for handling following mechanism

- update the users route

- add a partial for displaying follower stats

- add a partial for the follow/unfollow button and update the routes for user relationships

- add followers and following pages

- add a working follow button (by using jQuery): edit the relationship controller, the follow/unfollow partials and add two js.erb files

42) Extra: finish the implementation of the status feed

## LAB 13

43) Add a (simple) users' search form only for logged in users...

## LAB 14

44) Add a gem for private messaging: `simple-private-messages`

45) Partially implemented a private messaging system: you can now send a message to another user and read the received messages
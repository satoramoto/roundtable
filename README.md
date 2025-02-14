# RoundTable
RoundTable is an AI chatbot which simulates a round table discussion between 
Albert Einstein, Isaac Newton, and Nikola Tesla.

The goal of the project is to serve as an opinionated starting point for 
developers looking to build their own AI chatbot as quickly as possible.

This project assumes basic programming knowledge, but aims to be accessible to anyone who is willing to learn.

## Live Demo
[Check out the live demo](https://roundtableai-580da9ec0237.herokuapp.com/)

https://github.com/user-attachments/assets/890f8861-30d9-47d4-a033-dce5061ec00f

## Features & Concepts
- Fully functional chatbot with a custom system prompt
- Real-time UI updates with Turbo Streams
- Works with any AI provider which uses the OpenAI completion API
  - [Ollama](https://ollama.com)
  - [llama.cpp](https://github.com/ggerganov/llama.cpp)
  - [OpenAI](https://openai.com/api/) with your own API key
- Ready to be deployed to Heroku

## Getting Started
### Pre-requisites
- Docker for a quick contained postgres and redis instances
- rbenv to install ruby
- local AI provider (ollama, llama.cpp, etc) or OpenAI API key
- overmind to orchestrate everything in the development environment

On Mac you can install most of these with [homebrew](https://brew.sh/). 

[Ollama](https://ollama.com/download) is a great choice for an AI backend if you're just getting started.

### Getting the code and running the project
First let's get the code and install the dependencies.
```shell
cd ~/Source # or wherever you keep your projects
git clone https://github.com/satoramoto/roundtable.git
cd roundtable
rbenv install && bundle install
```

On Mac you may run into an issue with the `pg` gem, which must be built natively.
You can install the `libpq` library with homebrew and then configure the bundler to use it during build.
```shell
brew install libpq
bundle config build.pg --with-pg-config=/usr/local/opt/libpq/bin/pg_config
```

Next we create a `.env.development` file with the following contents. For simplicity, we'll use the OpenAI API.
```shell
OPEN_AI_BACKEND=https://api.openai.com
OPEN_AI_API_KEY=your-api-key-here
OPEN_AI_MODEL_NAME=gpt-4o-mini
```

Next lets bootstrap postgres with the database and the schema.
```shell
docker-compose up -d postgres
rails db:setup && rails db:migrate
docker-compose down
```

Finally, we can start the project with overmind.
```shell
overmind start -f Procfile.development
```

The application will be available at `http://localhost:5000`.

### Deploying to Heroku
These instructions are untested, but should give you the general idea of how to deploy this project to Heroku.
You can also use the Heroku UI to set up the project. Here we'll use the Heroku CLI.

Before we do anything, install the Heroku CLI and login.
```shell
brew tap heroku/brew && brew install heroku
heroku login
```

Now we can create a new Heroku app and add the Redis and Postgres addons.
```shell
heroku create your-app-name
heroku addons:create heroku-redis:hobby-dev
heroku addons:create heroku-postgresql:hobby-dev
```

Next, set the environment variables on Heroku.
```shell
heroku config:set OPEN_AI_BACKEND=https://api.openai.com
heroku config:set OPEN_AI_API_KEY=your-api-key-here
heroku config:set OPEN_AI_MODEL_NAME=gpt-4o-mini
```

In order to deploy the code, we need to set up the heroku remote.
```shell
heroku git:remote
```

Finally, push the code to Heroku to trigger a deployment.
```shell
git push heroku main
```

## FAQ & More
### Why did you do "stupid thing" or "Why didn't you do "smart thing"?
There were a number of features/approaches/etc I considered when doing this project, 
most of which were trade-offs between speed and complexity.

I wanted to make this project as simple as possible to get started with,
so I made a lot of decisions that may not be the best for every use case.

By no means is this a production-ready chatbot, but it should be a good starting point for most people.

I welcome pull requests if you have a better way to do something, or generally want to improve this example.

### Why Ruby on Rails?
I built this project because I wanted to learn more about AI and chatbots.
I chose Rails because it's a mature framework with a large community and a lot of resources.

Rails is opinionated, which means it makes a lot of decisions for you, 
which can be a good thing when you're just getting started.

Ruby itself is a very readable language, which makes it easy to understand what's going on in the code. 
Even if you're not familiar with Ruby, you should be able to follow along. Python developers will feel right at home.

Speaking of opinions, this project uses the Turbo and Hotwire libraries 
instead of React or some other fancy front-end framework.

### Why not React / Why Turbo and Hotwire?
Because we want to go fast. You wanted to learn about AI, not JavaScript frameworks, right?

Turbo and Hotwire are libraries from the creators of Rails that make it easy to 
build interactive web applications without writing a lot of JavaScript.

I think you'll find it easier to get started with Turbo and Hotwire than with React or another front-end framework.
But if you're already comfortable with those libraries, 
you can fork this project and use `react-rails` or whatever else to build your front-end.

### Going Further
Fork this repository and don't look back! Take whatever you need and ditch the rest. 

This project is meant to get you started quickly with all the basics. 

You should be able to copy the patterns here to do things like:
- Add a user system using the `ActiveRecord` models
- Change the system prompt to make that perfect assistant
- Iterate quickly on your own user interface

Or you can lift some of the infrastructure and build your own chatbot from scratch.

You may find the following bits interesting:
- The System Prompt
- The GitHub actions for CI/CD
- Turbo and Hotwire as an alternative to React

## Thanks!
If you found this project helpful, please consider giving it a star on GitHub.

If you want to say thanks, you can buy me a coffee at [ko-fi.com/ryangavin](https://ko-fi.com/ryangavin).

BTC: bc1qxsvryfcse92qzgdug2ujh6wqxpq6u2pp5sd9r0

XMR: 46oxUJ9iLX92SG1USCqNN2fezvcE26xBoef7dSCX9BhkT9ohnEk8uxhjc2r6961fBnUCJGBmryJMBAe5ronUxB3CADFT9eR

## License
This project is licensed under the MIT License. See LICENSE.txt for details.

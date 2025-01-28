# RoundTable
RoundTable is an AI chatbot which simulates a round table discussion between 
Albert Einstein, Isaac Newton, and Nikola Tesla.

The goal of the project is to serve as an opinionated starting point for 
developers looking to build their own AI chatbot as quickly as possible.

This project assumes basic programming knowledge, but aims to be accessible to anyone who is willing to learn.

https://github.com/user-attachments/assets/890f8861-30d9-47d4-a033-dce5061ec00f

## Features & Concepts
- Fully functional chatbot with a custom system prompt
- Real-time UI updates with Turbo Streams
- AI backend using `ollama` to allow any AI backend to be plugged in
- Dockerized database for quick setup
- Basic CI/CD with Github Actions

## Getting Started
### Pre-requisites
- Docker (for a quick contained postgres database)
- asdf (to install ruby)
- ollama (to run the AI models)
- overmind (to run all the services)

On mac you can install most of these with [homebrew](https://brew.sh/). 

Be careful if you already have docker desktop installed not to install it again.
```shell
brew install docker asdf overmind
```

See The [Ollama website](https://ollama.com/download) for instructions to install olama.

### Getting the code and running the project
```shell
cd ~/Source # or wherever you keep your projects
git clone https://github.com/satoramoto/roundtable.git
cd roundtable
asdf install
overmind start
```
The application will be available at `http://localhost:5000`.

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
- Ditch postgres for a cookie based session system
- Change the system prompt to make that perfect assistant

Or you can lift some of the infrastructure and build your own chatbot from scratch.

You may find the following bits interesting:
- Dockerization of the project
- The System Prompt
- The GitHub actions for CI/CD
- Turbo and Hotwire as an alternative to React

## License
This project is licensed under the MIT License. See LICENSE.txt for details.

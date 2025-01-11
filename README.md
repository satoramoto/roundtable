# RoundTable
RoundTable is an AI chatbot which simulates a round table discussion between 
Albert Einstein, Isaac Newton, and Nikola Tesla.

The goal of the project is to serve as an opinionated starting point for 
developers looking to build their own AI chatbot as quickly as possible.

This project assumes basic programming knowledge, but aims to be accessible to anyone who is willing to learn.

## Features & Concepts
- Fully functional chatbot with a custom system prompt
- Real-time UI updates with Turbo Streams
- AI backend using `LocalAI` to allow any AI backend to be plugged in
- Dockerized for easy deployment and development
- CI/CD with Github Actions

More subjectively, I believe this project is a great example of how to build a modern web application.

## Getting Started TLDR
1. Clone the repository
2. Run `docker compose up`
3. Visit `http://localhost:3000` in your browser

## Prerequisites
### The Code
You can clone this repository to your local machine by running the following command:

```shell
cd ~/Source # or wherever you keep your projects
git clone https://github.com/satoramoto/roundtable.git
cd roundtable
```

### Docker
The application and it's dependencies are dockerized, so you will need to have Docker installed on your machine.

If you don't have Docker installed, you can download it from the 
[official website](https://www.docker.com/products/docker-desktop).

### Ruby (Optional)
The dockerized version of the project contains everything you need to run the web application.

However, if you wish to run the web application locally without Docker, 
you will need to have Ruby installed on your machine.

The project has both a `.ruby-version` and `.tool-versions` file which specify the version of Ruby to use.

I personally recommend `asdf` for managing Ruby versions, but you can use `rvm` or `rbenv` as well.

See the [asdf-vm](https://asdf-vm.com/#/core-manage-asdf) website for instructions on how to install `asdf`.

```shell
# From the project root
asdf install
```

## Why Ruby on Rails?
I built this project because I wanted to learn more about AI and chatbots.
I chose Rails because it's a mature framework with a large community and a lot of resources.

Rails is opinionated, which means it makes a lot of decisions for you, 
which can be a good thing when you're just getting started.

Ruby itself is a very readable language, which makes it easy to understand what's going on in the code. 
Even if you're not familiar with Ruby, you should be able to follow along. Python developers will feel right at home.

Speaking of opinions, this project uses the Turbo and Hotwire libraries 
instead of React or some other fancy front-end framework.

## Why Turbo and Hotwire?
Because we want to go fast. You wanted to learn about AI, not JavaScript frameworks, right?

Turbo and Hotwire are libraries from the creators of Rails that make it easy to 
build interactive web applications without writing a lot of JavaScript.

I think you'll find it easier to get started with Turbo and Hotwire than with React or another front-end framework.
But if you're already comfortable with those libraries, 
you can fork this project and use `react-rails` or whatever else to build your front-end.

## Going Further
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

## Contributing
If you have any ideas for how this project could be improved, please open an issue or a pull request.

I would love to see this become the most useful starting point for AI chatbots and new developers.

## Hire Me
Need an AI "expert" or Rails dev? 
I have over a decade of professional experience building large systems in a range of languages.

I have been working daily with Ruby on Rails for the last 5 years, 
but I can speak python, java, and go if those are your style. 
If you have a project you think I can help on, I'd love to chat!

## License
This project is licensed under the MIT License. See LICENSE.txt for details.

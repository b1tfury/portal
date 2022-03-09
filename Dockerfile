FROM ruby:3.1.1

LABEL Name=portal Version=0.0.1

# throw errors if Gemfile has been modified since Gemfile.lock
RUN bundle config --global frozen 1


WORKDIR /portal
COPY . /portal

COPY Gemfile Gemfile.lock ./
RUN gem install bundler
RUN bundle install
COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh

ENTRYPOINT ["entrypoint.sh"]
EXPOSE 80

# Configure the main process to run when running the image
CMD ["bundle", "exec", "puma", "-p", "80"]


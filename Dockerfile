FROM timbru31/ruby-node:2.7-fermium AS builder

RUN gem install compass susy breakpoint
RUN npm install browserify coffeeify coffeescript

COPY ./frontend ./frontend
COPY config.rb .

RUN mkdir -p wedding_website/static

RUN compass compile -e production
RUN node_modules/.bin/browserify -t coffeeify frontend/index.coffee > wedding_website/static/wedding.js


FROM python:3.8-alpine

COPY requirements.txt .
RUN pip install -r requirements.txt

COPY wedding_website wedding_website
COPY ./test_app.py .
COPY ./secrets.json .
COPY --from=builder wedding_website/static/wedding.* wedding_website/static

ENV FLASK_APP=test_app.py
EXPOSE 5000

ENTRYPOINT ["flask", "run", "--host", "0.0.0.0"]
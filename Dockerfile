FROM timbru31/ruby-node:2.7-fermium AS build-env

RUN gem install compass susy breakpoint
RUN npm install browserify coffeeify coffeescript

COPY config.rb .

RUN mkdir -p wedding_website/static


FROM build-env as develop

VOLUME "/frontend"
VOLUME "/wedding_website/static/images"
VOLUME "/wedding_website/templates"

RUN npm install watchify
RUN apt-get update && apt-get install python3-pip -y
COPY requirements.txt .
RUN pip3 install -r requirements.txt

COPY ./wedding_website/*.py ./wedding_website
COPY ./app.py .
COPY ./secrets.json .

ENV FLASK_APP=app.py
ENV FLASK_ENV="development"
EXPOSE 5000

RUN echo "compass watch &" > entry.sh
RUN echo "node_modules/.bin/watchify -t coffeeify frontend/index.coffee -o wedding_website/static/wedding.js &" >> entry.sh
RUN echo "flask run --host 0.0.0.0" >> entry.sh
ENTRYPOINT [ "sh", "entry.sh" ]


FROM build-env as build-proc

COPY ./frontend ./frontend

RUN compass compile -e production
RUN node_modules/.bin/browserify -t coffeeify frontend/index.coffee -o wedding_website/static/wedding.js


FROM tiangolo/meinheld-gunicorn AS prod

COPY requirements.txt .
RUN pip3 install -r requirements.txt

COPY ./wedding_website ./app/wedding_website
COPY --from=build-proc ./wedding_website/static/wedding.* ./app/wedding_website/static
COPY ./app.py ./app/main.py
COPY ./secrets.json ./secrets.json

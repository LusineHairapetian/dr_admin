FROM hexpm/elixir:1.13.1-erlang-25.1.2-ubuntu-xenial-20210804

RUN mkdir -p /usr/src/med_admin
COPY . /usr/src/med_admin

WORKDIR /usr/src/med_admin

RUN mix local.hex --force

CMD [ "mix", "phx.server" ]
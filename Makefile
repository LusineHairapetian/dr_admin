.PHONY: help
SHELL := /bin/bash

build: 
		docker-compose up -d --build
setup:
		docker exec -it dr_admin /bin/bash -ci "mix deps.get && mix ecto.migrate && mix run priv/repo/seeds.exs"
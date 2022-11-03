# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     DrAdmin.Repo.insert!(%DrAdmin.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

alias DrAdmin.Repo
alias DrAdmin.Main.Specialty

specialties = ["Physiotherapist", "General Practitioner", "Psychotherapists"]

Enum.each(specialties, fn name -> 
  Repo.insert!(%Specialty{name: name})
end)
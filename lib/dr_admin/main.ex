defmodule DrAdmin.Main do
  @moduledoc """
  The Main context.
  """

  import Ecto.Query, warn: false
  alias DrAdmin.Repo

  alias DrAdmin.Main.Clinic
  alias DrAdmin.Main.Specialty


  @doc """
  Returns the list of specialties.

  ## Examples

      iex> list_specialties()
      [%Specialties{}, ...]

  """
  def list_specialties do
    Repo.all(Specialty)
  end

  @doc """
  Returns the list of clinics.

  ## Examples

      iex> list_clinics()
      [%Clinic{}, ...]

  """
  def list_clinics do
    Repo.all(Clinic)
  end

  @doc """
  Gets a single clinic.

  Raises `Ecto.NoResultsError` if the Clinic does not exist.

  ## Examples

      iex> get_clinic!(123)
      %Clinic{}

      iex> get_clinic!(456)
      ** (Ecto.NoResultsError)

  """
  def get_clinic!(id), do: Repo.get!(Clinic, id)

  @doc """
  Creates a clinic.

  ## Examples

      iex> create_clinic(%{field: value})
      {:ok, %Clinic{}}

      iex> create_clinic(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_clinic(attrs \\ %{}) do
    %Clinic{}
    |> Clinic.changeset(attrs)
    |> Repo.insert()
    |> broadcast([:clinic, :created])

  end

  @doc """
  Updates a clinic.

  ## Examples

      iex> update_clinic(clinic, %{field: new_value})
      {:ok, %Clinic{}}

      iex> update_clinic(clinic, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_clinic(%Clinic{} = clinic, attrs) do
    clinic
    |> Clinic.changeset(attrs)
    |> Repo.update()
    |> broadcast([:clinic, :updated])
  end

  @doc """
  Deletes a clinic.

  ## Examples

      iex> delete_clinic(clinic)
      {:ok, %Clinic{}}

      iex> delete_clinic(clinic)
      {:error, %Ecto.Changeset{}}

  """
  def delete_clinic(%Clinic{} = clinic) do
    Repo.delete(clinic)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking clinic changes.

  ## Examples

      iex> change_clinic(clinic)
      %Ecto.Changeset{data: %Clinic{}}

  """
  def change_clinic(%Clinic{} = clinic, attrs \\ %{}) do
    Clinic.changeset(clinic, attrs)
  end

  alias DrAdmin.Main.Practitioner

  @doc """
  Returns the list of practitioners.

  ## Examples

      iex> list_practitioners()
      [%Practitioner{}, ...]

  """
  def list_practitioners do
    Practitioner
    |> join(:inner, [p], s in assoc(p, :specialty))
    |> join(:inner, [p], c in assoc(p, :clinic))
    |> preload([_, s, c], specialty: s, clinic: c)
    |> Repo.all()
    
  end

  @doc """
  Gets a single practitioner.

  Raises `Ecto.NoResultsError` if the Practitioner does not exist.

  ## Examples

      iex> get_practitioner!(123)
      %Practitioner{}

      iex> get_practitioner!(456)
      ** (Ecto.NoResultsError)

  """
  def get_practitioner!(id) do
    Practitioner
    |> join(:inner, [p], s in assoc(p, :specialty))
    |> join(:inner, [p], c in assoc(p, :clinic))
    |> preload([_, s, c], specialty: s, clinic: c)
    |> Repo.get(id)
  end

  @doc """
  Creates a practitioner.

  ## Examples

      iex> create_practitioner(%{field: value})
      {:ok, %Practitioner{}}

      iex> create_practitioner(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_practitioner(attrs \\ %{}) do
    %Practitioner{}
    |> Practitioner.changeset(attrs)
    |> Repo.insert()
    |> broadcast([:practitioner, :created])
  end

  @doc """
  Updates a practitioner.

  ## Examples

      iex> update_practitioner(practitioner, %{field: new_value})
      {:ok, %Practitioner{}}

      iex> update_practitioner(practitioner, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_practitioner(%Practitioner{} = practitioner, attrs) do
    practitioner
    |> Practitioner.changeset(attrs)
    |> Repo.update()
    |> broadcast([:practitioner, :updated])
  end

  @doc """
  Deletes a practitioner.

  ## Examples

      iex> delete_practitioner(practitioner)
      {:ok, %Practitioner{}}

      iex> delete_practitioner(practitioner)
      {:error, %Ecto.Changeset{}}

  """
  def delete_practitioner(%Practitioner{} = practitioner) do
    Repo.delete(practitioner)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking practitioner changes.

  ## Examples

      iex> change_practitioner(practitioner)
      %Ecto.Changeset{data: %Practitioner{}}

  """
  def change_practitioner(%Practitioner{} = practitioner, attrs \\ %{}) do
    Practitioner.changeset(practitioner, attrs)
  end


  @topic inspect(__MODULE__)

  def subscribe do
    Phoenix.PubSub.subscribe(DrAdmin.PubSub, @topic)
  end

  defp broadcast({:error, _reason} = error, _event), do: error

  defp broadcast({:ok, result}, event) do
    Phoenix.PubSub.broadcast(DrAdmin.PubSub, @topic, {event, result})
    {:ok, result}
  end

end

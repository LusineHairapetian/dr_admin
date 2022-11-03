defmodule DrAdmin.MainTest do
  use DrAdmin.DataCase

  alias DrAdmin.Main

  describe "clinics" do
    alias DrAdmin.Main.Clinic

    import DrAdmin.MainFixtures

    @invalid_attrs %{address: nil, name: nil, phone_number: nil}

    test "list_clinics/0 returns all clinics" do
      clinic = clinic_fixture()
      assert Main.list_clinics() == [clinic]
    end

    test "get_clinic!/1 returns the clinic with given id" do
      clinic = clinic_fixture()
      assert Main.get_clinic!(clinic.id) == clinic
    end

    test "create_clinic/1 with valid data creates a clinic" do
      valid_attrs = %{address: "some address", name: "some name", phone_number: "some phone_number"}

      assert {:ok, %Clinic{} = clinic} = Main.create_clinic(valid_attrs)
      assert clinic.address == "some address"
      assert clinic.name == "some name"
      assert clinic.phone_number == "some phone_number"
    end

    test "create_clinic/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Main.create_clinic(@invalid_attrs)
    end

    test "update_clinic/2 with valid data updates the clinic" do
      clinic = clinic_fixture()
      update_attrs = %{address: "some updated address", name: "some updated name", phone_number: "some updated phone_number"}

      assert {:ok, %Clinic{} = clinic} = Main.update_clinic(clinic, update_attrs)
      assert clinic.address == "some updated address"
      assert clinic.name == "some updated name"
      assert clinic.phone_number == "some updated phone_number"
    end

    test "update_clinic/2 with invalid data returns error changeset" do
      clinic = clinic_fixture()
      assert {:error, %Ecto.Changeset{}} = Main.update_clinic(clinic, @invalid_attrs)
      assert clinic == Main.get_clinic!(clinic.id)
    end

    test "delete_clinic/1 deletes the clinic" do
      clinic = clinic_fixture()
      assert {:ok, %Clinic{}} = Main.delete_clinic(clinic)
      assert_raise Ecto.NoResultsError, fn -> Main.get_clinic!(clinic.id) end
    end

    test "change_clinic/1 returns a clinic changeset" do
      clinic = clinic_fixture()
      assert %Ecto.Changeset{} = Main.change_clinic(clinic)
    end
  end

  describe "practitioners" do
    alias DrAdmin.Main.Practitioner

    import DrAdmin.MainFixtures

    @invalid_attrs %{description: nil, name: nil, phone_number: nil, specialty: nil}

    test "list_practitioners/0 returns all practitioners" do
      practitioner = practitioner_fixture()
      assert Main.list_practitioners() == [practitioner]
    end

    test "get_practitioner!/1 returns the practitioner with given id" do
      practitioner = practitioner_fixture()
      assert Main.get_practitioner!(practitioner.id) == practitioner
    end

    test "create_practitioner/1 with valid data creates a practitioner" do
      valid_attrs = %{description: "some description", name: "some name", phone_number: "some phone_number", specialty: "some specialty"}

      assert {:ok, %Practitioner{} = practitioner} = Main.create_practitioner(valid_attrs)
      assert practitioner.description == "some description"
      assert practitioner.name == "some name"
      assert practitioner.phone_number == "some phone_number"
      assert practitioner.specialty == "some specialty"
    end

    test "create_practitioner/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Main.create_practitioner(@invalid_attrs)
    end

    test "update_practitioner/2 with valid data updates the practitioner" do
      practitioner = practitioner_fixture()
      update_attrs = %{description: "some updated description", name: "some updated name", phone_number: "some updated phone_number", specialty: "some updated specialty"}

      assert {:ok, %Practitioner{} = practitioner} = Main.update_practitioner(practitioner, update_attrs)
      assert practitioner.description == "some updated description"
      assert practitioner.name == "some updated name"
      assert practitioner.phone_number == "some updated phone_number"
      assert practitioner.specialty == "some updated specialty"
    end

    test "update_practitioner/2 with invalid data returns error changeset" do
      practitioner = practitioner_fixture()
      assert {:error, %Ecto.Changeset{}} = Main.update_practitioner(practitioner, @invalid_attrs)
      assert practitioner == Main.get_practitioner!(practitioner.id)
    end

    test "delete_practitioner/1 deletes the practitioner" do
      practitioner = practitioner_fixture()
      assert {:ok, %Practitioner{}} = Main.delete_practitioner(practitioner)
      assert_raise Ecto.NoResultsError, fn -> Main.get_practitioner!(practitioner.id) end
    end

    test "change_practitioner/1 returns a practitioner changeset" do
      practitioner = practitioner_fixture()
      assert %Ecto.Changeset{} = Main.change_practitioner(practitioner)
    end
  end
end

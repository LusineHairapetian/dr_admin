defmodule DrAdminWeb.ClinicLiveTest do
  use DrAdminWeb.ConnCase

  import Phoenix.LiveViewTest
  import DrAdmin.MainFixtures

  @create_attrs %{address: "some address", name: "some name", phone_number: "some phone_number"}
  @update_attrs %{address: "some updated address", name: "some updated name", phone_number: "some updated phone_number"}
  @invalid_attrs %{address: nil, name: nil, phone_number: nil}

  defp create_clinic(_) do
    clinic = clinic_fixture()
    %{clinic: clinic}
  end

  describe "Index" do
    setup [:create_clinic]

    test "lists all clinics", %{conn: conn, clinic: clinic} do
      {:ok, _index_live, html} = live(conn, Routes.clinic_index_path(conn, :index))

      assert html =~ "Listing Clinics"
      assert html =~ clinic.address
    end

    test "saves new clinic", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, Routes.clinic_index_path(conn, :index))

      assert index_live |> element("a", "New Clinic") |> render_click() =~
               "New Clinic"

      assert_patch(index_live, Routes.clinic_index_path(conn, :new))

      assert index_live
             |> form("#clinic-form", clinic: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#clinic-form", clinic: @create_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.clinic_index_path(conn, :index))

      assert html =~ "Clinic created successfully"
      assert html =~ "some address"
    end

    test "updates clinic in listing", %{conn: conn, clinic: clinic} do
      {:ok, index_live, _html} = live(conn, Routes.clinic_index_path(conn, :index))

      assert index_live |> element("#clinic-#{clinic.id} a", "Edit") |> render_click() =~
               "Edit Clinic"

      assert_patch(index_live, Routes.clinic_index_path(conn, :edit, clinic))

      assert index_live
             |> form("#clinic-form", clinic: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#clinic-form", clinic: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.clinic_index_path(conn, :index))

      assert html =~ "Clinic updated successfully"
      assert html =~ "some updated address"
    end

    test "deletes clinic in listing", %{conn: conn, clinic: clinic} do
      {:ok, index_live, _html} = live(conn, Routes.clinic_index_path(conn, :index))

      assert index_live |> element("#clinic-#{clinic.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#clinic-#{clinic.id}")
    end
  end

  describe "Show" do
    setup [:create_clinic]

    test "displays clinic", %{conn: conn, clinic: clinic} do
      {:ok, _show_live, html} = live(conn, Routes.clinic_show_path(conn, :show, clinic))

      assert html =~ "Show Clinic"
      assert html =~ clinic.address
    end

    test "updates clinic within modal", %{conn: conn, clinic: clinic} do
      {:ok, show_live, _html} = live(conn, Routes.clinic_show_path(conn, :show, clinic))

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Clinic"

      assert_patch(show_live, Routes.clinic_show_path(conn, :edit, clinic))

      assert show_live
             |> form("#clinic-form", clinic: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        show_live
        |> form("#clinic-form", clinic: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.clinic_show_path(conn, :show, clinic))

      assert html =~ "Clinic updated successfully"
      assert html =~ "some updated address"
    end
  end
end

defmodule DrAdminWeb.PractitionerLiveTest do
  use DrAdminWeb.ConnCase

  import Phoenix.LiveViewTest
  import DrAdmin.MainFixtures

  @create_attrs %{description: "some description", name: "some name", phone_number: "some phone_number", specialty: "some specialty"}
  @update_attrs %{description: "some updated description", name: "some updated name", phone_number: "some updated phone_number", specialty: "some updated specialty"}
  @invalid_attrs %{description: nil, name: nil, phone_number: nil, specialty: nil}

  defp create_practitioner(_) do
    practitioner = practitioner_fixture()
    %{practitioner: practitioner}
  end

  describe "Index" do
    setup [:create_practitioner]

    test "lists all practitioners", %{conn: conn, practitioner: practitioner} do
      {:ok, _index_live, html} = live(conn, Routes.practitioner_index_path(conn, :index))

      assert html =~ "Listing Practitioners"
      assert html =~ practitioner.description
    end

    test "saves new practitioner", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, Routes.practitioner_index_path(conn, :index))

      assert index_live |> element("a", "New Practitioner") |> render_click() =~
               "New Practitioner"

      assert_patch(index_live, Routes.practitioner_index_path(conn, :new))

      assert index_live
             |> form("#practitioner-form", practitioner: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#practitioner-form", practitioner: @create_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.practitioner_index_path(conn, :index))

      assert html =~ "Practitioner created successfully"
      assert html =~ "some description"
    end

    test "updates practitioner in listing", %{conn: conn, practitioner: practitioner} do
      {:ok, index_live, _html} = live(conn, Routes.practitioner_index_path(conn, :index))

      assert index_live |> element("#practitioner-#{practitioner.id} a", "Edit") |> render_click() =~
               "Edit Practitioner"

      assert_patch(index_live, Routes.practitioner_index_path(conn, :edit, practitioner))

      assert index_live
             |> form("#practitioner-form", practitioner: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#practitioner-form", practitioner: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.practitioner_index_path(conn, :index))

      assert html =~ "Practitioner updated successfully"
      assert html =~ "some updated description"
    end

    test "deletes practitioner in listing", %{conn: conn, practitioner: practitioner} do
      {:ok, index_live, _html} = live(conn, Routes.practitioner_index_path(conn, :index))

      assert index_live |> element("#practitioner-#{practitioner.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#practitioner-#{practitioner.id}")
    end
  end

  describe "Show" do
    setup [:create_practitioner]

    test "displays practitioner", %{conn: conn, practitioner: practitioner} do
      {:ok, _show_live, html} = live(conn, Routes.practitioner_show_path(conn, :show, practitioner))

      assert html =~ "Show Practitioner"
      assert html =~ practitioner.description
    end

    test "updates practitioner within modal", %{conn: conn, practitioner: practitioner} do
      {:ok, show_live, _html} = live(conn, Routes.practitioner_show_path(conn, :show, practitioner))

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Practitioner"

      assert_patch(show_live, Routes.practitioner_show_path(conn, :edit, practitioner))

      assert show_live
             |> form("#practitioner-form", practitioner: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        show_live
        |> form("#practitioner-form", practitioner: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.practitioner_show_path(conn, :show, practitioner))

      assert html =~ "Practitioner updated successfully"
      assert html =~ "some updated description"
    end
  end
end

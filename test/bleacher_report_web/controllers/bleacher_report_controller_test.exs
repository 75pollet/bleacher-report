defmodule BleacherReportWeb.BleacherReportControllerTest do
  use BleacherReportWeb.ConnCase

  setup do
    insertion_attrs = %{
      "user_id" => "1234",
      "action" => "add",
      "content_id" => "05ac456jhn-3456g",
      "reaction_type" => "reaction",
      "type" => "fire"
    }

    [attrs: insertion_attrs]
  end

  test "reaction/2 saves reactions to the cache", %{attrs: attrs, conn: conn} do
    conn = conn |> post("/reaction", attrs)

    assert conn.status == 200
    assert conn.resp_body == "ok"
  end

  test "reaction/2 does not save reaction if the reaction for the user has already been saved", %{
    attrs: attrs,
    conn: conn
  } do
    conn |> post("/reaction", attrs)
    conn = conn |> post("/reaction", attrs)

    assert conn.status == 422
    assert conn.resp_body == "reaction for this user exists"
  end

  test "reaction/2 removes a reaction", %{attrs: attrs, conn: conn} do
    conn |> post("/reaction", attrs)
    attrs = %{attrs | "action" => "remove"}

    conn = conn |> post("/reaction", attrs)

    assert conn.status == 200
    assert conn.resp_body == "ok"
  end

  test "reaction/2 when a reaction does not exist", %{attrs: attrs, conn: conn} do
    conn |> post("/reaction", attrs)
    attrs = %{attrs | "action" => "remove"}

    conn |> post("/reaction", attrs)
    conn = conn |> post("/reaction", attrs)

    assert conn.status == 422
    assert conn.resp_body == "reaction doesn't exist"
  end

  test "count/2 returns the number of reactions for a specific content id", %{
    attrs: attrs,
    conn: conn
  } do
    conn |> post("/reaction", attrs)
    content_id = attrs["content_id"]
    conn = conn |> get("/reaction_counts/#{content_id}")

    assert conn.status == 200

    resp_body = Jason.decode!(conn.resp_body)

    assert resp_body == %{
             "content_id" => content_id,
             "reaction_count" => %{"fire" => 1}
           }
  end
end

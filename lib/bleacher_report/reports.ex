defmodule BleacherReport.Reports do
  @moduledoc """
    This is where the logics of inserting, updating and
    deleting is done
  """

  @cache :bleacher_cache

  @doc """
  deletes reaction from the cache
  """
  def remove_from_cache(%{"content_id" => content_id, "user_id" => user_id}) do
    reactions = get_reactions(content_id)

    case _check_for_existing_reaction(reactions, user_id) do
      true ->
        reactions =
          Enum.reject(reactions, fn %{"user_id" => user} ->
            user == user_id
          end)

        ConCache.put(@cache, content_id, reactions)

      false ->
        :does_not_exist
    end
  end

  @doc """
  insert a reaction into the ets cache
  """
  def save_to_cache(%{"content_id" => content_id, "user_id" => user_id} = params) do
    reactions = get_reactions(content_id)

    case _check_for_existing_reaction(reactions, user_id) do
      true ->
        :exists

      false ->
        new_value = _add_new_value_to_cache(content_id, params)

        ConCache.put(@cache, content_id, new_value)
    end
  end

  defp _add_new_value_to_cache(content_id, params) do
    case get_reactions(content_id) do
      nil -> [params]
      reactions -> reactions |> List.insert_at(-1, params)
    end
  end

  defp _check_for_existing_reaction(nil, _user_id) do
    false
  end

  defp _check_for_existing_reaction(reactions, user_id) do
    reactions
    |> Enum.any?(fn %{"user_id" => user} -> user_id == user end)
  end

  @doc """
  get the reactions for a specific content id
  """
  def get_reactions(content_id) do
    ConCache.get(@cache, content_id)
  end
end

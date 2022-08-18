defmodule ShoppingListChallenge do
  @spec generate_bill_by_email(list(map()), list(String.t())) :: map()
  def generate_bill_by_email(_items_list, emails) do
    with :ok <- validate_emails_format(emails) do
      emails
    end
  end

  defp validate_emails_format(emails) do
    are_all_email_valid? = Enum.all?(emails, fn email -> Regex.match?(~r/@/, email) end)

    case are_all_email_valid? do
      false -> {:error, message: "Invalid e-mail format"}
      true -> :ok
    end
  end
end

defmodule ShoppingListChallenge do
  @spec generate_bill_by_emails(list(map()), list(String.t())) :: map()
  def generate_bill_by_emails(_items_list, emails) when is_list(emails) and length(emails) > 0 do
    with :ok <- validate_emails_format(emails),
         :ok <- validate_email_duplication(emails) do
      emails
    end
  end

  def generate_bill_by_emails(_items_list, []), do: {:error, message: "Emails list is empty"}

  defp validate_emails_format(emails) do
    are_all_email_valid? = Enum.all?(emails, fn email -> Regex.match?(~r/@/, email) end)

    case are_all_email_valid? do
      false -> {:error, message: "Invalid e-mail format"}
      true -> :ok
    end
  end

  defp validate_email_duplication([_first_email | _] = emails) do
    unique_emails = Enum.uniq(emails)

    case length(emails) > length(unique_emails) do
      true -> {:error, message: "Duplicated emails"}
      false -> :ok
    end
  end
end

defmodule UserApi.User do
	use Ecto.Schema
	import Ecto.Changeset
	import Ecto.Query

	schema "users" do
		field(:name, :string)
		field(:age, :integer)
		field(:company)
		field(:city)
		timestamps()
	end

	def search(user_id) do
		query = (from u in UserApi.User,
			where: u.id == ^user_id,
			select: u
			)

		UserApi.Repo.one(query)
	end
end
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

	def create_changeset(user = %UserApi.User{}, params) do
		user 
		|> cast(params, [:name, :age, :company])#toma datos en bruto y nos permite definir que datos queremos. Es como un filtro.
		|> validate_required([:name, :age])
	end

	def search(user_id) do
		query = (from u in UserApi.User,
			where: u.id == ^user_id,
			select: u
			)
		UserApi.Repo.one(query)
	end

	def search_all do
		query =
		 from(u in UserApi.User,
		 	select: [u.name, u.age]#Lo utilizamos para que al mapear el objeto con la bd solo traigamos los campos que queremos
		 	)
		 UserApi.Repo.all(query)
	end
end
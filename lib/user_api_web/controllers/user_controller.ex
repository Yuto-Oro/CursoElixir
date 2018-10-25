defmodule UserApiWeb.UserController do
	use UserApiWeb, :controller 

	def index(conn, _params) do

		users = UserApi.User.search_all() #Search all eregresa una lista de mapas.
		conn
		|> put_status(200)
		|> json(users)
	end
	
	def show(conn, %{"id" => user_id}) do
		IO.inspect(self())
		
		case UserApi.User.search(user_id) do
			nil ->
				conn
				|> put_status(404)
				|> text("Error!!")
			_user ->
				conn
				|> put_status(200)
				|> text("Exito!!")
		end
	end

	def create(conn, params) do
		changeset = UserApi.User.create_changeset(%UserApi.User{}, params)
		IO.inspect(changeset)
		case changeset.valid? do
			true ->
				user = UserApi.Repo.insert!(changeset) #El '!' lanza una excepcion en caso de que falle el changeset. Genera un crash del proceso.
				conn
				|>put_status(200)
				|>json(%{user: %{name: user.name, user_id: user.id}})
			false -> 
				conn
				|> put_status(400)
				|> put_status("Error en los datos")

		end
		conn
		|> put_status(200)
		|> text("Create")
	end
end
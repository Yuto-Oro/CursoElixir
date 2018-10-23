defmodule UserApiWeb.UserController do
	use UserApiWeb, :controller 

	def index(conn, _params) do
		conn
		|> put_status(401)
		|> text("Unauth")
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

	def create(conn, _params) do
		changeset = UserApi.User.create_changeset(%UserApi.User{}, params)

		case changeset.valid? do
			true ->
				user = UserApi.Repo.insert!(changeset) #El '!' lanza una excepcion en caso de que falle el changeset
				conn
				|>put_status(200)
				|>text("Elemento insertado")
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
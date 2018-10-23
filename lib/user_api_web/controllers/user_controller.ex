defmodule UserApiWeb.UserController do
	use UserApiWeb, :controller 

	def index(conn, _params) do
		conn
		|> put_status(401)
		|> text("Unauth")
	end
	
	def show(conn, _params) do
		case UserApi.User.search(1) do
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
		conn
		|> put_status(200)
		|> text("Create")
	end
end
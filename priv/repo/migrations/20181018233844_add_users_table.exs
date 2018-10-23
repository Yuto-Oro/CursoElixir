defmodule UserApi.Repo.Migrations.AddUsersTable do
  use Ecto.Migration

  def change do
  	create table(:users) do
  		add(:name, :string)
  		add(:age, :integer)
  		add(:company, :string)
  		add(:city, :string)
  		timestamps() 
  	end
  end
end

class UserSerializer < ActiveModel::Serializer
  attributes :id, :email, :role_name
end

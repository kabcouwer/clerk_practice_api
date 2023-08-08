class UserSerializer
  include JSONAPI::Serializer
  attributes :first_name, :last_name, :email, :phone_number, :street_address, :city, :state, :zip_code
end

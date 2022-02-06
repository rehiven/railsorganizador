# == Schema Information
#
# Table name: categories
#
#  id          :bigint           not null, primary key
#  name        :string
#  description :text
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
class Category < ApplicationRecord
  has_many :tasks

#valida que se encuentren los campos
  validates :name, :description, presence: true
#valida que solo exista un registro con ese nombre
#case_sensitive es para ignorar mayusculas
  validates :name, uniqueness: {case_sensitive: false}
end

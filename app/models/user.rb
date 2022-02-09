# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  #estas son las creadas directamente por el usuario
  has_many :owned_tasks
  #se esta termiendo una participacion en la tarea
  has_many :participations, class_name: 'Participant'
  #son las tareas en la que participa el usuario no necesariamente las que crea.
  has_many :tasks, through: :participations
end

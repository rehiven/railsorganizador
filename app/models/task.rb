# == Schema Information
#
# Table name: tasks
#
#  id          :bigint           not null, primary key
#  name        :string
#  description :text
#  due_date    :date
#  category_id :bigint           not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
class Task < ApplicationRecord
  #tiene categorias
  belongs_to :category
  #tiene un creador 'owner' atraves de clase 'user'
  belongs_to :owner, class_name: 'User'
  #tiene muchos participantes, atraves de la clase 'participants'
  has_many :participating_user, class_name: 'Participant'
  #esto es para vincular usuarios atraves de participantes
  has_many :participants, through: :participating_users, source: :user
#valida que se encuentren los campos

#validaciones***************************************************************
  validate :participating_users, presence: true

  validates :name, :description, presence: true
#valida que solo exista un registro con ese nombre
#case_sensitive es para ignorar mayusculas
  validates :name, uniqueness: {case_sensitive: false}
  validate :due_date_validity

  def due_date_validity
    return if due_date.blank?
    return if due_date > Date.today
    #este metodo pasa errores a la vista
    errors.add :due_date, I18n.t('task.errors.invalid_due_date')
  end
end

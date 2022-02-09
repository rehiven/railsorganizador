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
#  owner_id    :bigint           not null
#  code        :string
#
class Task < ApplicationRecord
  #tiene categorias
  belongs_to :category
  #tiene un creador 'owner' atraves de clase 'user'
  belongs_to :owner, class_name: 'User'
  #tiene muchos participantes, atraves de la clase 'participants'
  has_many :participating_users, class_name: 'Participant'
  #esto es para vincular usuarios atraves de participantes
  has_many :participants, through: :participating_users, source: :user

  has_many :notes
  #validaciones***************************************************************

  #valida que se encuentren los campos
  validates :participating_users, presence: true
  #valida que solo exista un registro con ese nombre
  #case_sensitive es para ignorar mayusculas
  validates :name, uniqueness: {case_insensitive: false}
  validate :due_date_validity

  before_create :create_code
  after_create :send_email

  accepts_nested_attributes_for :participating_users, allow_destroy: true

  def due_date_validity
    return if due_date.blank?
    return if due_date > Date.today
    #este metodo pasa errores a la vista
    errors.add :due_date, I18n.t('task.errors.invalid_due_date')
  end

  def create_code
    self.code = "#{owner_id}#{Time.now.to_i.to_s(36)}#{SecureRandom.hex(8)}"
  end

  def send_email
    (participants + [owner]).each do |user|
      ParticipantMailer.with(user: user, task: self).new_task_email.deliver!
    end
  end

end

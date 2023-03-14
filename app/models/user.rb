class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :conditions
  has_many :restrictions_ingredients_users
  has_many :ingredients, through: :restrictions_ingredients_users


  def User.get_data_for_radar_chart
    @get_data_for_radar_chart ||= begin
      roles = User.distinct.pluck(:weight)
      {
        indicators: roles.inject({}) {|res, e| res[e] = User.maximum(:height); res},
        data: [
          {
            name: 'Average Height',
            value: roles.map{|e| User.where(weight: e).average(:height).round(2)}
          },
          {
            name: 'Maximum Height',
            value: roles.map{|e| User.where(weight: e).maximum(:height).round(2)}
          }
        ],
      }
    end
  end
end

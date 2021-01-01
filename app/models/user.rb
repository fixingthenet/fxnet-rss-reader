# == Schema Information
#
# Table name: users
#
#  id         :bigint           not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
#  devise :database_authenticatable, :registerable,
#         :recoverable, :rememberable, :trackable, :validatable,
#         :confirmable, :lockable, :timeoutable
end

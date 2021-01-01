# == Schema Information
#
# Table name: stories
#
#  id         :bigint           not null, primary key
#  title      :text
#  permalink  :text
#  body       :text
#  entry_id   :text
#  feed_id    :integer          not null
#  published  :datetime
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
require 'rails_helper'

RSpec.describe Story do

  it "extracts pure text" do
    s=Stroy.new
    s.body=''
  end
end

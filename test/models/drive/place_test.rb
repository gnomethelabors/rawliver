# == Schema Information
#
# Table name: drive_places
#
#  id           :bigint(8)        not null, primary key
#  code         :string(255)      not null
#  section_type :string(255)
#  name         :string(255)
#  lat          :float(24)        default(0.0), not null
#  lon          :float(24)        default(0.0), not null
#  prefecture   :string(255)
#  city         :string(255)
#  postal_code  :string(255)
#  address      :string(255)      not null
#  tel          :string(255)
#  extra_infos  :text(65535)
#  options      :text(65535)
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

require 'test_helper'

class Drive::PlaceTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end

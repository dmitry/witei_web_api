require 'test_helper'

class WiteiWebApi::HouseTest < WiteiWebApi::Test
  def test_find
    VCR.use_cassette('house/find', record: VCR_RECORD_MODE) do
      house = WiteiWebApi::House.find('B827')
      assert_equal '2149346', house.owner_id
      assert_equal '11006', house.commercial_id
      assert_equal '11006', house.creator_id
      assert_equal nil, house.recruiter_id
      assert_equal '', house.partner_id
      assert house.owner.is_a?(WiteiWebApi::Contact)
      assert_nil house.partner
      assert house.commercial.is_a?(WiteiWebApi::OfficeUser)
      assert_nil house.recruiter
      assert house.creator.is_a?(WiteiWebApi::OfficeUser)
    end
  end
end

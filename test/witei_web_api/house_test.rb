require 'test_helper'

class WiteiWebApi::HouseTest < WiteiWebApi::Test
  def setup
    Thread.current[:witei_web_api_agent] = nil
  end

  def test_find
    VCR.use_cassette('house/find', record: VCR_RECORD_MODE) do
      house = WiteiWebApi::House.find('00913')
      assert_equal '2136240', house.owner_id
      assert_equal '10992', house.commercial_id
      assert_equal '10992', house.creator_id
      assert_nil house.recruiter_id
      assert_equal '', house.partner_id
      assert house.owner.is_a?(WiteiWebApi::Contact)
      assert_nil house.partner
      assert house.commercial.is_a?(WiteiWebApi::OfficeUser)
      assert_nil house.recruiter
      assert house.creator.is_a?(WiteiWebApi::OfficeUser)
    end
  end

  def test_relogin_after_expiration
    VCR.use_cassette('house/relogin_after_expiration', record: VCR_RECORD_MODE) do
      WiteiWebApi::House.find('5V900')
      session = WiteiWebApi::Base.agent.cookies.find { |v| v.name == 'sessionid' }
      session.value = ''
      assert_equal 0, session.value.length
      WiteiWebApi::House.find("5V900")
      session = WiteiWebApi::Base.agent.cookies.find { |v| v.name == 'sessionid' }
      assert_equal 32, session.value.length
    end
  end
end

require 'test_helper'

class WiteiWebApi::BaseTest < WiteiWebApi::Test
  def setup
    @base = WiteiWebApi::Base.new
  end

  def test_login
    VCR.use_cassette('login', record: VCR_RECORD_MODE) do
      assert_equal true, @base.login(ENV['login'], ENV['password'])
    end
  end

  def test_find_property_by_identifier
    VCR.use_cassette('find_property_by_identifier', record: VCR_RECORD_MODE) do
      assert_equal true, @base.login(ENV['login'], ENV['password'])
      data = {
        :owner=>{
          :name=>"Baltasar Ponte",
          :email=>"baltasarponte@gmail.com",
          :phone=>"0034687453907",
          :phone_alt=>"",
          :comercial_id=>"11006"
        }
      }
      assert_equal(data, @base.find_property_by_identifier('b827'))
    end
  end
end

class WiteiWebApi::House < WiteiWebApi::Base
  attr_accessor :owner_id, :partner_id, :recruiter_id, :commercial_id, :creator_id, :notes

  has_one(:owner) { WiteiWebApi::Contact }
  has_one(:partner) { WiteiWebApi::Contact }
  has_one(:recruiter) { WiteiWebApi::OfficeUser }
  has_one(:commercial) { WiteiWebApi::OfficeUser }
  has_one(:creator) { WiteiWebApi::OfficeUser }

  def self.find(identifier)
    id = id_by_identifier(identifier)
    page = get("/pro/house/update/#{id}/")

    form = page.forms_with(css: '.form-horizontal').first

    house = new
    house.assign_attributes(
      owner_id: form['owner'],
      partner_id: form['partner'],
      recruiter_id: form['recruiter'],
      commercial_id: form['commercial'],
      creator_id: form['creator'],
      notes: form['notes']
    )
    house
  end

  def self.id_by_identifier(identifier)
    page = get("/pro/agencies/houses/list/?_hidden__action_identifier_bcd32c=unacc_eq&_hidden_identifier_bcd32c=#{identifier}&listView=block")
    page.css('#id_houses_0').first['value']
  end
end

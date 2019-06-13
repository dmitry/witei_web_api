class WiteiWebApi::House < WiteiWebApi::Base
  attr_accessor :owner_id,
                :partner_id,
                :recruiter_id,
                :commercial_id,
                :creator_id,
                :keys,
                :sign_displayed,
                :notes,
                :ref_number,
                :agreement_type,
                :agreement_valid_from,
                :agreement_valid_until,
                :commission_amount,
                :commission_shared_percent,
                :commission_percent,
                :street,
                :street_number,
                :province,
                :town,
                :zip_code,
                :district,
                :zone,
                :urbanization,
                :block,
                :doorway,
                :door,
                :floor

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
      keys: form['keys'],
      sign_displayed: form['sign_displayed'],
      notes: form['notes'],
      ref_number: form['ref_number'],
      agreement_type: form['agreement_type'],
      agreement_valid_from: form['agreement_valid_from'],
      agreement_valid_until: form['agreement_valid_until'],
      commission_amount: form['commission_amount'],
      commission_shared_percent: form['commission_shared_percent'],
      commission_percent: form['commission_percent'],
      street: form['street'],
      street_number: form['street_number'],
      province: form['province'],
      town: form['town'],
      zip_code: form['zip_code'],
      district: form['district'],
      zone: form['zone'],
      urbanization: form['urbanization'],
      block: form['block'],
      doorway: form['doorway'],
      door: form['door'],
      floor: form['floor']
    )
    house
  end

  def self.id_by_identifier(identifier)
    page = get("/pro/agencies/houses/list/?_hidden__action_identifier_bcd32c=unacc_eq&_hidden_identifier_bcd32c=#{identifier}&listView=block")
    page.css('#id_houses_0').first['value']
  end
end

class WiteiWebApi::Contact < WiteiWebApi::Base
  attr_accessor :name, :email, :phone, :phone_alt, :commercial_id

  has_one(:commercial) { WiteiWebApi::OfficeUser }

  def self.find(id)
    page = agent.get "https://witei.com/pro/agencies/contact/#{id}/update/"
    form = page.forms_with(css: '.form-horizontal').first

    contact = new
    contact.assign_attributes(
      name: form['name'],
      email: form['email'],
      phone: form['phone'],
      phone_alt: form['phone_alt'],
      commercial_id: form['commercial']
    )
    contact
  end
end
class WiteiWebApi::OfficeUser < WiteiWebApi::Base
  attr_accessor :id, :name, :email, :phone

  def self.find(id)
    page = get("/pro/agencies/account_management/agency/user_update/#{id}/")

    form = page.forms_with(css: '#user_form').first

    office_user = new
    office_user.assign_attributes(
      id: id,
      name: form['username'],
      email: form['email'],
      phone: form['phone']
    )
    office_user
  end
end

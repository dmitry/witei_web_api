class WiteiWebApi::OfficeUser < WiteiWebApi::Base
  attr_accessor :id, :name, :email, :phone

  # def self.all
  #   agent.get 'https://witei.com/pro/agencies/account_management/agency_users/'
  # end

  def self.find(id)
    page = agent.get "https://witei.com/pro/agencies/account_management/agency/user_update/#{id}/"

    form = page.forms_with(css: '.form-horizontal').first

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
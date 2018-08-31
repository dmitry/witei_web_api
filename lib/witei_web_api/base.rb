module WiteiWebApi
  class Base
    include ActiveModel::AttributeAssignment

    private

    def self.agent
      Thread.current[:witei_web_api_agent] ||= begin
        agent = WiteiWebApi::Agent.new
        login!(agent)
        agent
      end
    end

    def self.login(agent, login, password)
      page = agent.get 'https://witei.com/pro/accounts/login/?next=/pro/agencies/dashboard/'

      form = page.form_with class: 'form-horizontal'
      form.login = login
      form.password = password
      x = form.submit
      x.uri.path == '/pro/agencies/dashboard/'
    end

    def self.login!(agent)
      unless login(agent, WiteiWebApi.login, WiteiWebApi.password)
        raise(LoginFailedException.new)
      end
    end

    def self.has_one(name, &block)
      define_method(name) do
        id = send(:"#{name}_id")
        if id && !id.empty?
          block.call.find(id)
        end
      end
    end

    class LoginFailedException < Exception
    end
  end
end

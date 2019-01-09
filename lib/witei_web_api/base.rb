require 'thread'

module WiteiWebApi
  class Base
    include ActiveModel::AttributeAssignment

    private

    def self.agent
      Thread.current[:witei_web_api_agent] ||= begin
        agent = WiteiWebApi::Agent.new
        login(agent)
        agent
      end
    end

    def self.login(agent, login: WiteiWebApi.login, password: WiteiWebApi.password, uri: nil)
      uri ||= '/pro/agencies/dashboard/'
      page = agent.get("https://witei.com/pro/accounts/login/?next=#{CGI.escape(uri)}")

      form = page.form_with(class: 'form-horizontal')
      form.login = login
      form.password = password
      new_page = form.submit
      if new_page.uri.path != URI.parse(uri).path
        raise(LoginFailedException.new)
      end
      new_page
    end

    def self.has_one(name, &block)
      define_method(name) do
        id = send(:"#{name}_id")
        if id && !id.empty?
          block.call.find(id)
        end
      end
    end

    def self.get(uri)
      page = agent.get("https://witei.com#{uri}")
      uri_path = URI.parse(uri).path
      if page.uri.path != uri_path
        page = login(agent, uri: uri)
        if page.uri.path != uri_path
          raise LoggedOutException.new("Cannot get #{uri}")
        end
      end
      page
    end

    class LoginFailedException < Exception
    end

    class LoggedOutException < Exception
    end
  end
end

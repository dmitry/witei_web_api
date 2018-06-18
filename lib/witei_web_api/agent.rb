require 'mechanize'

module WiteiWebApi
  class Agent < Mechanize
    def initialize
      super('witei_web_api')
      
      @agent.user_agent = "Witei Web Api (#{WiteiWebApi::VERSION})"
      @agent.open_timeout = 10
      @agent.read_timeout = 10
    end
  end
end

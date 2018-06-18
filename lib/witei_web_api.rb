require 'rubygems'
require 'bundler/setup'
require 'json'
require 'active_model/forbidden_attributes_protection'
require 'active_model/attribute_assignment'

Bundler.require

module WiteiWebApi
  require 'witei_web_api/version'
  require 'witei_web_api/agent'
  require 'witei_web_api/base'
  require 'witei_web_api/house'
  require 'witei_web_api/contact'
  require 'witei_web_api/office_user'
end

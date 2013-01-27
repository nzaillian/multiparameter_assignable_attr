require File.expand_path('../../active_record_ext/multiparameter_assignable_attr', __FILE__)
require 'rails'

module MultiparameterAssignableAttr
  class Railtie < Rails::Railtie
    initializer "multiparameter_assignable_attr.configure_rails_initialization" do
      ActiveRecord::Base.send(:include, ::ActiveRecordExt::MultiparameterAssignableAttr)
    end    
  end
end
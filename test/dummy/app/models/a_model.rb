class AModel < ActiveRecord::Base
  attr_accessible :start_date, :start_time

  multiparameter_assignable_attr :start_time => DateTime
end
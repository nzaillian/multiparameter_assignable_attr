About
=====

This gem provides a simple patch that allows you to set transient (non-db-backed) model attributes from multiparameter attribute groups (like those passed by date/time select form elements).  

Usage
=====

Add the following to your Gemfile:
    gem 'multiparameter_assignable_attr'

and run 'bundle install' (or just 'bundle')
    $ bundle

That's it, you can now mark transient atributes as multiparameter-assignable with the following macro:

    multiparameter_assignable_attr :attribute_name => AttributeClass

See below for more info and examples.

More Info
=========
Let's say you have a class "Employee" and you have added a transient "enrollment_time" attribute to it (perhaps so that you can cleanly place separate date and time inputs in your form).  If you have your model definition is as follows:

    class Member
      attr_accessible :name, :email, :enrollment_date

      attr_accessor :enrollment_time

      before_save :merge_enrollment_date_and_time

      private

      def merge_enrollment_date_and_time
        if enrollment_time
          self.enrollment_date = self.enrollment_date.change(
            :hour => enrollment_time.hour,
            :min => enrollment_time.min
          )
        end
      end
    end

...and the following form:

    <%= form_for @member do |f| %>
      Name:
      <%= f.text_field :name %>
      <br />

      Enrollment Date:
      <%= f.datepicker :enrollment_date %>
      <br />

      Enrollment Time:
      <%= f.time_select :enrollment_time %>
      <br />

      <%= f.submit %>
    <% end %>

...and you try to process it via mass assignment:

    # app/controllers/members_controller.rb
    # ...

    def create
      @member = Member.new(params[:member])

      if @save
        redirect_to :action => 'index'
      else
        render :action => 'new'
      end
    end

    # ...

...you will get an error like:

    ActiveRecord::MultiparameterAssignmentErrors
    1 error(s) on assignment of multiparameter attributes

This error occurs because the value for the transient "start\_time" attribute is being passed in as a so-called "multiparameter attribute" (attribute composed of multiple keys, ex: 'start\_time(1i)', 'start\_time(2i)', 'start\_time(3i)'...).  In order to parse the multiparameter attribute into the appropriate object, ActiveRecord must know the target attribute type.  It does the lookup in the body of the following method from 'lib/activerecord/attribute\_assignment.rb'

    def read_value_from_parameter(name, values_hash_from_param)
      klass = (self.class.reflect_on_aggregation(name.to_sym) || column_for_attribute(name)).klass
      if values_hash_from_param.values.all?{|v|v.nil?}
        nil
      elsif klass == Time
        read_time_parameter_value(name, values_hash_from_param)
      elsif klass == Date
        read_date_parameter_value(name, values_hash_from_param)
      else
        read_other_parameter_value(klass, name, values_hash_from_param)
      end
    end

This patch just overrides the default implementation of ActiveRecord.reflect\_on\_aggregation to return the appropriate class for indicated transient attributes instead of nil (and defer to super for the other attributes).  To use it, we would update our class definition to use the multiparameter\_assignable\_attr macro:


    class Member
      attr_accessible :name, :email, :enrollment_date

      multiparameter_assignable_attr :enrollment_time => DateTime

      before_save :merge_enrollment_date_and_time

      private

      def merge_enrollment_date_and_time
        if enrollment_time
          self.enrollment_date = self.enrollment_date.change(
            :hour => enrollment_time.hour,
            :min => enrollment_time.min
          )
        end
      end
    end

Now when ActiveRecord looks up the type of Member's "enrollment\_date" attribute via reflect\_on\_aggregation, it will get an OpenStruct with a klass attribute set to DateTime and the assignment from the multiparameter attribute will go forward. 
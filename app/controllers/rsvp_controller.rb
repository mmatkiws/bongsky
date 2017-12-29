class RsvpController < ApplicationController
	def send(variable)

      @name   = "none"
      @email  = "none"
      @guests = ""

  	  if(params.has_key?(:name))
  	    @name = params[:name]
  	  end

  	  if(params.has_key?(:attending))
        if(params[:attending] == "attending")
          @attending = true
        else
          @attending = false
        end
  	  end

      if(params.has_key?(:email))
      	@email = params[:email]
      end

  	  if(params.has_key?(:guest1))
  	  	@guests += params[:guest1]
  	  end

      if(params.has_key?(:guest2))
        @guests += ", " + params[:guest2]
      end

      if(params.has_key?(:guest3))
        @guests += ", " + params[:guest3]
      end

      if(params.has_key?(:guest4))
        @guests += ", " + params[:guest4]
      end

      if(params.has_key?(:guest5))
        @guests += ", " + params[:guest5]
      end

      if(params.has_key?(:guest6))
        @guests += ", " + params[:guest6]
      end

      if(params.has_key?(:guest7))
        @guests += ", " + params[:guest7]
      end
      
      if(params.has_key?(:guest8))
        @guests += ", " + params[:guest8]
      end

      if(params.has_key?(:guest9))
        @guests += ", " + params[:guest9]
      end

      if(params.has_key?(:guest10))
        @guests += ", " + params[:guest10]
      end

      # Save to Dynamo
      begin
        resp = $ddb.put_item({
          table_name: 'bongsky-rsvp',
          item: {
                  'name' => @name, 
                  'attending' => @attending ? 1 : 0,
                  'email' => @email,
                  'guests' => @guests
                }
        })
        resp.successful?
      rescue Aws::DynamoDB::Errors::ServiceError => e
        false
      end

      RsvpMailer.rsvp_email(@name, @email, @attending, @guests).deliver

      if(params.has_key?(:attending))
      	if (@attending)
  	  	  redirect_to '/pages/rsvp/#sent', :flash => { :notice => "See you soon!  If anything changes, just RSVP again." }
  	    else
  	  	  redirect_to '/pages/rsvp/#sent', :flash => { :notice => "Aww shucks!  If you change your mind just RSVP again." }
        end
      else
      	redirect_to '/pages/rsvp/#error', :flash => { :notice => "Please let us know if you can make it or not." }
      end
    end
end

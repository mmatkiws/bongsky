class UploadsController < ApplicationController
    def send(variable)
      
        params.permit(:public, :title, :body, :image, :remove_image, :image_cache, :remote_image_url, photos: [])

	    if(params.has_key?(:public))
	        allowPublic = true
	    else
	        allowPublic = false
	    end

	    if(params.has_key?(:photos) && !params[:photos].blank?)
	        hasImages = true
	    else
	        hasImages = false
	    end

	    if(hasImages)
	    	#u = Upload.new(photos: Hash[params[:photos].map.with_index.to_a])
	    	
	    	#params[:photos].key_value do |key, value|
            #    u = Upload.new
            #    u.public = allowPublic
            #    u.ip = request.remote_ip
                
            #    print "=============="
            #    print key
            #    print value
            #    print u.public
                #u.photos = "{" + photo + "}"
            #    print u.photos
            #    print u.ip
            #    print "=============="
            #    u.save!
            #end	    	


	    	@u = Upload.new(params[:photos])
	    	@u.public = true
	    	@u.ip = request.remote_ip

	        print "======================"
	        print @u
	    	print @u.public
	    	print @u.photos
	        print params[:photos]
	        #print params[:photos].map
	        #print params[:photos].map.with_index
	    	print @u.ip

	        @u.photos = params[:photos]


	        print @u.photos
	        print "======================"

            @u.save!

	        if (allowPublic)
	  	        redirect_to '/pages/uploads/#sent', :flash => { :notice => "Thanks for the pics, feel free to upload some more!" } and return
	  	    else
	  	  	    redirect_to '/pages/uploads/#sent', :flash => { :notice => "Thanks a lot!  If you change your mind, upload them again!" } and return
	        end
	    else
	      	redirect_to '/pages/uploads/#error', :flash => { :notice => "No valid images uploaded, try again." } and return
	    end

  end
end
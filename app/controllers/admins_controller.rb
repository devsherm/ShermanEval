class AdminsController < ApplicationController
    before_action :authenticate_user!
    before_action :admin_only!
    
    def index
        
    end
end
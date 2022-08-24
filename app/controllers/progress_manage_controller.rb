class ProgressManageController < ApplicationController

    #
    # 初期表示
    #
    def index
    end

    def holidays
        @actualHolidays = ActualHoliday.all
        render json: @actualHolidays
    end

    def statuses
    end

    def users
    	
        jsonText = ""
        users = User.all
        users.each{|user|
            if jsonText == ""
                jsonText += "{"
            else
                jsonText += ","
            end
            jsonText += "\"" + user.id.to_s + "\":\"" + user.lastname + " " + user.firstname + "\""
        }
        jsonText += "}"

        render json: JSON.parse(jsonText)
    end

    def search
    end

end

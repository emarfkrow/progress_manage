class ProgressManageController < ApplicationController

    #
    # 初期表示
    #
    def index
    end

    def holidays
    
    	jsonText = ""
        actualHolidays = ActualHoliday.all
        actualHolidays.each{|actualHoliday|
            if jsonText == ""
                jsonText += "{"
            else
                jsonText += ","
            end
            jsonText += "\"" + actualHoliday.holiday + "\":\"1\""
		}
    
        render json: JSON.parse(jsonText)
    end

    def statuses
    
    	jsonText = ""
        statuses = Status.all
        statuses.each{|status|
            if jsonText == ""
                jsonText += "{"
            else
                jsonText += ","
            end
            jsonText += "\"" + status.id + "\":\"" + status.name + "\""
		}
    
        render json: JSON.parse(jsonText)
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
    
    	jsonText = ""
        actualSpans = Issue
			.joins("INNER JOIN issue_statuses ist on ist.id = issues.status_id ")
			.joins("LEFT JOIN actual_spans as on as.issue_id = issues.id")
			.select("issues.*, actual_spans.*")
			.where(["ist.is_closed = :closed", {:closed => false}])
			.all
        actualSpans.each{|actualSpan|
            if jsonText == ""
                jsonText += "{"
            else
                jsonText += ","
            end
            jsonText += "\"" + actualSpan.issue_id + "\":{"
            jsonText += "\"id\":\"" + actualSpan.issue_id + "\","
            jsonText += "\"eoDays\":\"" + actualSpan.eoDays + "\""
            jsonText += "}"
		}
    
        render json: JSON.parse(jsonText)
    end

end

class ProgressManageController < ApplicationController

    #
    # 初期表示
    #
    def index
    end

    #
    # 休日リスト
    #
    def holidays
    	jsonText = ""
        ActualHoliday.all.each{|actualHoliday|
            if jsonText == ""
                jsonText += "{"
            else
                jsonText += ","
            end
            jsonText += "\"" + actualHoliday.holiday + "\":\"1\""
		}
        render json: JSON.parse(jsonText)
    end

    #
    # ステータスリスト
    #
    def statuses
    	jsonText = ""
        Status.all.each{|status|
            if jsonText == ""
                jsonText += "{"
            else
                jsonText += ","
            end
            jsonText += "\"" + status.id + "\":\"" + status.name + "\""
		}
        render json: JSON.parse(jsonText)
    end

    #
    # ユーザーリスト
    #
    def users
        jsonText = ""
        User.all.each{|user|
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

    #
    # チケット実積リスト
    #
    def search
    	jsonText = ""
        Issue
			.joins("INNER JOIN issue_statuses ist on ist.id = issues.status_id ")
			.joins("LEFT JOIN actual_spans as on as.issue_id = issues.id")
            .joins(:project)
			.select("issues.*, actual_spans.*, projects.name as project_name")
			.where(["ist.is_closed = :closed", {:closed => false}])
			.all
			.each{|actualSpan|
            if jsonText == ""
                jsonText += "{"
            else
                jsonText += ","
            end
            jsonText += "\"#" + actualSpan.issue_id + "\":{"
            jsonText += "\"id\":\"#" + actualSpan.issue_id + "\","
            jsonText += "\"projectName\":\"#" + actualSpan.project_name + "\","
            jsonText += "\"version\":\"#" + actualSpan.version + "\","
            jsonText += "\"statusId\":\"#" + actualSpan.statusId + "\","
            jsonText += "\"assignedId\":\"#" + actualSpan.assignedId + "\","
            jsonText += "\"subject\":\"#" + actualSpan.subject + "\","
            jsonText += "\"boDays\":\"#" + actualSpan.boDays + "\","
            jsonText += "\"boDate\":\"#" + actualSpan.boDate + "\","
            jsonText += "\"days\":\"#" + actualSpan.days + "\","
            jsonText += "\"suspends\":\"#" + actualSpan.suspends + "\","
            jsonText += "\"manDays\":\"#" + actualSpan.manDays + "\","
            jsonText += "\"eoDate\":\"#" + actualSpan.eoDate + "\","
            jsonText += "\"eoDays\":\"" + actualSpan.eoDays + "\""
            jsonText += "}"
		}
        render json: JSON.parse(jsonText)
    end

    #
    # 休日リスト洗い替え
    #
    def setHolidays
		ActualHoliday.delete()
		params.each{|k,v|
			holiday = k
			permitted = params.permit(k)
            ActualHoliday.create(permitted)
		}
        render json: params
    end

    #
    # チケット更新
    #
    def putIssue
        permitted = params.permit(:id, :status_id, :assigned_to_id, :start_date, :due_date)
        issue = Issue.find(id)
        if issue == nil
            issue = Issue.create(permitted)
        else
            issue = Issue.update(permitted)
        end
        render json: issue
    end

    #
    # 実績日数更新
    #
    def putActualSpan
        permitted = params.permit(:id, :bo_days, :bo_date, :days, :suspends, :man_days, :eo_date, :eo_Days)
        actualSpan = ActualSpan.find(id)
        if actualSpan == nil
            actualSpan = ActualSpan.create(permitted)
        else
            actualSpan = ActualSpan.update(permitted)
        end
        render json: actualSpan
    end

end

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
    	jsonText = "{"
        ActualHoliday.all.each{|actualHoliday|
            if jsonText != "{"
                jsonText += ","
            end
            jsonText += "\"" + actualHoliday.holiday + "\":\"1\""
		}
		jsonText += "}"
        render json: JSON.parse(jsonText)
    end

    #
    # ステータスリスト
    #
    def statuses
    	jsonText = "{"
        IssueStatus.all.each{|status|
            if jsonText != "{"
                jsonText += ","
            end
            jsonText += "\"" + status.id.to_s + "\":\"" + status.name + "\""
		}
		jsonText += "}"
        render json: JSON.parse(jsonText)
    end

    #
    # ユーザーリスト
    #
    def users
    	jsonText = "{"
        User.all.each{|user|
            if jsonText != "{"
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
    	jsonText = "{"
        Issue
			.joins("INNER JOIN issue_statuses ist on ist.id = issues.status_id ")
			.joins("LEFT OUTER JOIN actual_spans s on s.issue_id = issues.id")
			.joins("LEFT OUTER JOIN versions v on v.id = issues.fixed_version_id")
            .joins(:project)
			.select("issues.*, s.id as actual_span_id, s.bo_days, s.bo_date, s.days, s.suspends, s.man_days, s.eo_date, s.eo_days, projects.name as project_name, v.name as version")
			.where(["ist.is_closed = :closed", {:closed => false}])
			.all
			.each{|actualSpan|
            if jsonText != "{"
                jsonText += ","
            end
            jsonText += "\"#" + actualSpan.id.to_s + "\":{"
            jsonText += "\"id\":\"#" + actualSpan.id.to_s + "\","
            jsonText += "\"projectName\":\"" + actualSpan.project_name + "\","
            jsonText += "\"version\":\"" + actualSpan.version + "\","
            jsonText += "\"statusId\":\"" + actualSpan.status_id.to_s + "\","
            jsonText += "\"assignedId\":\"" + actualSpan.assigned_to_id.to_s + "\","
            jsonText += "\"startDate\":\"" + actualSpan.start_date.to_s + "\","
            jsonText += "\"dueDate\":\"" + actualSpan.due_date.to_s + "\","
            jsonText += "\"subject\":\"" + actualSpan.subject + "\","
            jsonText += "\"lockVersion\":\"" + actualSpan.lock_version.to_s + "\","
            jsonText += "\"actualSpanId\":\"" + actualSpan.actual_span_id.to_s + "\","
            jsonText += "\"boDays\":\"" + actualSpan.bo_days.to_s + "\","
            jsonText += "\"boDate\":\"" + actualSpan.bo_date.to_s + "\","
            jsonText += "\"days\":\"" + actualSpan.days.to_s + "\","
            jsonText += "\"suspends\":\"" + actualSpan.suspends.to_s + "\","
            jsonText += "\"manDays\":\"" + actualSpan.man_days.to_s + "\","
            jsonText += "\"eoDate\":\"" + actualSpan.eo_date.to_s + "\","
            jsonText += "\"eoDays\":\"" + actualSpan.eo_days.to_s + "\""
            jsonText += "}"
		}
        jsonText += "}"
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
        permitted = params.permit(:id, :status_id, :assigned_to_id, :start_date, :due_date, :lock_version)
        issue = Issue.find(params[:id])
        issue.update(permitted)
        render json: issue
    end

    #
    # 実績日数更新
    #
    def putActualSpan
        permitted = params.permit(:id, :issue_id, :bo_days, :bo_date, :days, :suspends, :man_days, :eo_date, :eo_days)
        actualSpan = ActualSpan.where(["issue_id = :issue_id", {:issue_id => params[:issue_id]}]).all
        if actualSpan.count == 0
            actualSpan = ActualSpan.create(permitted)
        else
            actualSpan.update(permitted)
        end
        render json: actualSpan
    end

end

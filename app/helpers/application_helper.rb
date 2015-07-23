module ApplicationHelper
    def is_active_controller(controller_name)
        params[:controller] == controller_name ? "active" : nil
    end

    def is_active_action(action_name)
        params[:action] == action_name ? "active" : nil
    end

    def score_warning(score)
      return "progress-bar-danger" if score<=40
      return "progress-bar-warning" if score<=60
      ""
    end 

    def score_mapping(patient_score)
      [
        ["Clinical Score",       @patient_score[:clin_overall]],
        ["Behavior Score",       @patient_score[:beha_overall]],
        ["Demography Score",     @patient_score[:demo_overall]],
        ["Environmental Score",  @patient_score[:envi_overall]],
        ["Sensor Score",         @patient_score[:sens_overall]]
      ]
    end 
end

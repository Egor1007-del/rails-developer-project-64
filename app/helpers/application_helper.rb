# frozen_string_literal: true

module ApplicationHelper
  def map_alert_type(type)
    { notice: 'info', error: 'danger', success: 'success' }.fetch(type.to_sym, 'info')
  end
end

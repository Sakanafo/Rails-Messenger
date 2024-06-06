# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include Pagy::Backend

  def after_sign_in_path_for(resource)
    messages_path || root_path
  end

  def after_sign_out_path_for(resource_or_scope)
    request.referer || root_path
  end
end

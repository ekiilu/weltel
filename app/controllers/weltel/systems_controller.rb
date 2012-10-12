# -*- encoding : utf-8 -*-
module Weltel
  class SystemsController < ApplicationController
    include Authentication::AuthenticatedController
    layout("private/application")

    respond_to(:html)

    def show
      @logs = Dir.glob(File.join(Rails.root, 'log', '*.log')).map {|f| File.basename(f)}
    end
  end
end

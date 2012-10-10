# -*- encoding : utf-8 -*-
module Weltel
  class SystemsController < ApplicationController
    include Authentication::AuthenticatedController
    layout("private/application")

    respond_to(:html)

    def show
    end
  end
end

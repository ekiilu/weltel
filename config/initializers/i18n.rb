#-  -*- encoding : utf-8 -*- 
#- This Source Code Form is subject to the terms of the Mozilla Public
#- License, v. 2.0. If a copy of the MPL was not distributed with this
#- file, You can obtain one at http://mozilla.org/MPL/2.0/.

require "i18n"

#if Rails.env.development?
#  module I18n
#    class << self
#      def translate_with_debug(*args)
#        Rails.logger.debug("Translate: #{args.inspect}")
#        translate_without_debug(*args)
#      end
#      alias_method_chain(:translate, :debug)
#    end
#  end
#end

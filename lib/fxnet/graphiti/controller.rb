module Fxnet
  module Graphiti
    module Controller
#      include ActionController::HttpAuthentication::Basic::ControllerMethods
#      include ActionController::HttpAuthentication::Token::ControllerMethods
      def self.included(ctrl)
        ctrl.include ::Graphiti::Rails::Responders
#        ctrl.use Metoda::Graphiti::Middleware
        #Error handlers
        ctrl.register_exception Fxnet::Errors::NotAuthenticated, status: 401, detail: ->(ex) { ex.message }
#        ctrl.register_exception Fxnet::Errors::TokenNotFound, status: 403, detail: ->(ex) { ex.message }
#        ctrl.register_exception Fxnet::Errors::CanNotCreate, status: 403, detail: ->(ex) { ex.message }
#        ctrl.register_exception Fxnet::Errors::AttributeMissing, status: 422, detail: ->(ex) { ex.message }
        ctrl.register_exception ::Graphiti::Errors::RecordNotFound, status: 404, detail: ->(ex) { ex.message }
        ctrl.register_exception ::Graphiti::Errors::RequiredFilter, status: 400, detail: ->(ex) { ex.message }
        ctrl.register_exception ::Graphiti::Errors::InvalidInclude, status: 400, detail: ->(ex) { ex.message }
        ctrl.register_exception ::Graphiti::Errors::UnknownAttribute, status: 400, detail: ->(ex) { ex.message }
        ctrl.register_exception ::Graphiti::Errors::SideloadQueryBuildingError, status: 400, detail: ->(ex) { ex.message }
        ctrl.include(InstanceMethods)
      end

      module InstanceMethods
        private

        def show_detailed_exceptions?
          Rails.env.test? || Rails.env.development?
        end

        def _security_context
          return @security_context if @security_context
          @security_context = security_context
#          ElasticAPM.set_user(@security_context.user.me)
          @security_context
        end

        def authenticate!
          raise Fxnet::Errors::NotAuthenticated if _security_context.user.guest?
        end

        def basic_auth
          authenticate_with_http_basic {|u,p| p}
        end

        def api_key_from_headers
          auth = request.headers['Authorization']

          if auth.include? "Basic"
            auth.sub!('Basic','').strip!
            auth = Base64.decode64(auth).split(":")[1]
          end
          auth.split("=").last.gsub('"', '') if auth
        end
      end
    end
  end
end

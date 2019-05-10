module Api
  module Errors
    extend ActiveSupport::Concern
    included do
      rescue_from ActiveRecord::RecordNotFound, with: :not_found!

      def not_found!(exception)
        # TODO
        # move messages to locales
        render json: { error: 'not_found' }, status: 404
      end
    end
  end
end

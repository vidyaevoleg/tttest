module Users
  class InviteOperation < ApplicationOperation
    extend Contract::DSL

    contract "params", (Dry::Validation.Schema do
      # first check
      required(:email).filled(format?: Devise.email_regexp)
      required(:role_id).filled
      required(:name).filled
      required(:project_id).filled
      required(:location_id).filled
    end)

    contract "persistance", (Dry::Validation.Schema do
      # validation with db transaction
      configure do
        config.messages_file = 'config/locales/invite_errors.yml'
        def role_present?(value)
          Role.find_by(id: value)
        end

        def project_present?(value)
          Project.find_by(id: value)
        end

        def location_present?(value)
          # TODO
          # check that locations belongs_to project
          true
        end
      end
      required(:role_id).filled(:role_present?)
      required(:project_id).filled(:project_present?)
      required(:location_id).filled(:location_present?)
    end)

    contract "uniqueness", (Dry::Validation.Schema do
      # TODO
      # if User with specified email is already created - we have tocheck that user hasn't this user_role already
    end)

    step Contract::Validate(name: "params")
    step :find_model!
    step Contract::Validate(name: "persistance")
    step Contract::Validate(name: "uniqueness")
    # TODO add Rescue, Wrap for steps model + bind_models
    # step Rescue( ActiveRecord::ActiveRecordError, handler: :rollback! ) do
    # step Wrap ->(*, &block) { ActiveRecord::Base.transaction { block.call } } } do
    step :model!
    step :bind_models!

    failure :merge_errors!

    def find_model!(options, params: , **)
      options["model"] = User.find_by(email: params[:email])
      true
    end

    def model!(options, params: , **)
      options["model"] ||= User.invite!(params.slice(:email, :name))
    end

    def bind_models!(options, model: , params:, **)
      UserRole.create!(params.slice(:role_id, :project_id).merge(user_id: model.id))
      model.projects_location_ids = [ params[:location_id] ]
    end

    def merge_errors!(options, **kwargs)
      # TODO
      # I guess there is should be more smarter way to merge errors from all contracts
      errors = {}
      [:params, :persistance, :uniqueness].each do |contract_name|
        errors.merge!(options["result.contract.#{contract_name}"]&.errors || {})
      end
      options['result.errors'] = errors
    end
  end
end

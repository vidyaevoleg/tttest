module Users
  class InviteOperation < ApplicationOperation
    extend Contract::DSL

    contract "params", (Dry::Validation.Schema do
      required(:email).filled(format?: Devise.email_regexp)
      required(:role_id).filled
      required(:name).filled
      required(:project_id).filled
      required(:location_id).filled
    end)

    contract "persistance", (Dry::Validation.Schema do
      required(:role).filled
      required(:location).filled
      required(:project).filled
      # check that location is in project
    end)

    contract "uniqueness", (Dry::Validation.Schema do
      configure do
        config.messages_file = 'config/locales/invite_errors.yml'
      end
      required(:role).filled
      required(:location).filled
      required(:project).filled
      # check that user already have user_role and location
    end)

    step Contract::Validate(name: "params")
    step :setup_models!
    step Contract::Validate(name: "persistance")
    step :find_model!
    step Contract::Validate(name: "uniqueness")
    failure :merge_errors!
    # step Rescue( ActiveRecord::ActiveRecordError, handler: :rollback! ) do
    #   step Wrap ->(*, &block) { ActiveRecord::Base.transaction { block.call } } } do
        step :model!
        step :bind_models!
    #   end
    # end

    def setup_models!(options, params:, **)
      params[:role] = Role.find_by(id: params[:role_id])
      params[:project] = Project.find_by(id: params[:project_id])
      params[:location] = Location.find_by(id: params[:location_id])
      true
    end

    def find_model!(options, params: , **)
      options["model"] = User.find_by(email: params[:email])
      true
    end

    def model!(options, params: , **)
      options["model"] ||= User.invite!(params.slice(:email, :name))
    end

    def bind_models!(options, model: , params:, **)
      model.user_roles.create!(params.slice(:role, :project))
      model.projects_locations << params[:location]
    end

    def merge_errors!(options, **kwargs)
      # I guess there is should be more smarter way to merge errors from all contracts
      errors = {}
      [:params, :persistance, :uniqueness].each do |contract_name|
        errors.merge!(options["result.contract.#{contract_name}"]&.errors || {})
      end
      options['result.errors'] = errors
    end
  end
end

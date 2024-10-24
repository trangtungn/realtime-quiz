require_relative '../config/environment'
Rails.application.eager_load!

# Configure logging
logger = ActiveSupport::Logger.new(STDOUT)
logger.formatter = Rails.logger.formatter
Rails.logger = logger

# Log Action Cable events
ActionCable.server.config.logger = logger
ActionCable.server.config.log_tags = [:action_cable]

# Log connection and disconnection events
ActionCable.server.config.connection_class.class_eval do
  def connect
    logger.info "Client connected"
    super
  end

  def disconnect
    logger.info "Client disconnected"
    super
  end
end

run ActionCable.server

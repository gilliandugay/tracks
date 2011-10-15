require 'tilt'

module Tilt

class HamlJsTemplate < Tilt::Template
  def self.default_mime_type
    'application/javascript'
  end

  def evaluate(scope, locals, &block)
    ::Haml::Engine.new(File.read(scope.pathname.to_s)).render
  end

protected
  def basename(path)
    path.gsub(%r{.*/}, '')
  end

  def prepare; end
end

end # module Tilt

class Engine < ::Rails::Engine
  initializer "sprockets.handlebars", :after => "sprockets.environment" do |app|
    next unless app.assets
    app.assets.register_engine('.hamljs', Tilt::HamlJsTemplate)
  end
end


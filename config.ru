require './config/environment'

if ActiveRecord::Migrator.needs_migration?
  raise 'Migrations are pending. Run `rake db:migrate` to resolve the issue.'
end

# allows interpretation of post methods with parameter "_method"
use Rack::MethodOverride
use WritersController
use ListsController
use ListItemsController
run ApplicationController

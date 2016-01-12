$:.unshift("./backend")
require 'lib/static-app'
run XingBase::StaticApp.build("frontend/bin", ENV['XNG_BACKEND_PORT'])

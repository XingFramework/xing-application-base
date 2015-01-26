$:.unshift("./backend")
require 'backend/lib/static-app'
run LrdCms2::StaticApp.build("frontend/bin", ENV['LRD_BACKEND_PORT'])

namespace :db do
  desc 'schemaの適用'
  task :apply do
    sh 'ridgepole -c config/ridgepole.yml --apply -f db/schema/Schemafile'
  end
end

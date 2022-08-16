every 20.minutes do
  rake 'remove:old_transactions', :environment => "development"
end

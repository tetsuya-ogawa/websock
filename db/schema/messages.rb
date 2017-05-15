create_table 'massages', force: true do |t|
  t.text 'content'
  t.datetime 'created_at'
  t.datetime 'updated_at'
end
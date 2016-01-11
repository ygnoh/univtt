raise 'lol I am actually executed'

# RDS
ENV['RDS_USERNAME'] = 'devunivtt'
ENV['RDS_PASSWORD'] = 'startup2015'
ENV['RDS_HOSTNAME'] = 'univtt-db.chl0wmdsqtty.ap-northeast-1.rds.amazonaws.com'
ENV['RDS_PORT'] = '5432'

if Rails.env.development?
  ENV['RDS_DB_NAME'] = 'univtt_development'
elsif Rails.env.production?
  ENV['RDS_DB_NAME'] = 'univtt_production'
end

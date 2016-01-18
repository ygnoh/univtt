# RDS
ENV['RDS_USERNAME'] = 'devunivtt'
ENV['RDS_PASSWORD'] = 'startup2015'
ENV['RDS_HOSTNAME'] = 'univtt-db-seoul.ctvnqanvy3df.ap-northeast-2.rds.amazonaws.com'

ENV['RDS_PORT'] = '5432'

if Rails.env.development?
  ENV['RDS_DB_NAME'] = 'univtt_development'
elsif Rails.env.production?
  ENV['RDS_DB_NAME'] = 'univtt_production'
end

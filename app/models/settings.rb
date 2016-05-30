class Settings < Settingslogic

  source Rails.root.join('config', 'application.yml').to_s
  namespace Rails.env

end

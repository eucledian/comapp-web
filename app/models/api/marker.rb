class Api::Marker < Marker

  module Json
    List = {
      only: [:id, :name],
      methods: [:icon_url]
    }
  end

  def self.list
    all
  end

  def icon_url
    icon.url if icon.present?
  end
end

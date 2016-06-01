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
    #FIXME paperclip namespace error
    if icon.present?
      icon.url.gsub(/\/api\//, '/')
    end
  end
end

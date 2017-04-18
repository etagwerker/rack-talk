# rack/random_gif

require 'giphy'

class RandomGif
  KEYWORDS = ['cat', 'dog', 'panda'].freeze
  API_KEY = "dc6zaTOxFJmzC"

  def initialize(app)
    @keyword = KEYWORDS.shuffle.first
    @app = app
  end

  def call(env)
    status, headers, body = @app.call(env)

    [status, headers, random_bodies(body)]
  end

  private

  def random_bodies(body)
    body.map do |fragment|
      fragment.sub!(/<\/body>/, "#{img_tag}</body>")
    end
  end

  def img_tag
    giphy = Giphy.random(@keyword)
    source_url = giphy.image_original_url.to_s
    "<br/><img src='#{source_url}'/><br/>"
  end
end

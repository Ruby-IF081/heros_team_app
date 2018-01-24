module BasePresenterHelper
  def urlify(uri)
    URI.parse(uri).scheme ? uri : "http://#{uri}"
  end
end

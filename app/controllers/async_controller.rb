class AsyncController < ActionController::Metal
  include AbstractController::Layouts
  include ActionController::Rendering
  include ActionController::RequestForgeryProtection

  protect_from_forgery

  append_view_path "#{Rails.root}/app/views"

  def index
    http = EM::HttpRequest.new('http://slowapi.com/delay/1').get
    http.callback do
      @res = http.response
      request.env['async.callback'].call [
        200,
        { 'Content-Type' => 'text/html' },
        render('async/index', :layout => 'application')
      ]
    end

    throw :async
  end
end

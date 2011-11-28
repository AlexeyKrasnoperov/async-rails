class AsyncController < ActionController::Base
  def index
    http = EM::HttpRequest.new('http://slowapi.com/delay/1').get
    http.callback do
      @res = http.response
      request.env['async.callback'].call [
        200,
        { 'Content-Type' => 'text/html' },
        render('index', :layout => 'application')
      ]
    end

    throw :async
  end
end

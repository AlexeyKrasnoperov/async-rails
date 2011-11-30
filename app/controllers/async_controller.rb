class AsyncController < ApplicationController
  def index
    http = EM::HttpRequest.new('http://slowapi.com/delay/1').get
    http.callback do
      @res = http.response

      render
      request.env['async.callback'].call(response)
    end

    throw :async
  end
end

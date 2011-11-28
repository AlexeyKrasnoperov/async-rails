class AsyncController < ActionController::Metal
  def index
    EM.next_tick do
      request.env['async.callback'].call [
        200, {}, ['Hello, world']]
    end

    throw :async
  end
end

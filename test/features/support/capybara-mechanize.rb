Capybara.default_host = 'example.com'

class Capybara::Driver::Mechanize
  alias original_remote? remote?

  def remote?(url)
    uri = URI.parse(url)
    if uri.relative?
      last_request_remote? && remote_response.page.response['Location'] == url
    else
      (Capybara.app_host || Capybara.default_host) != uri.host
    end
  end
end
